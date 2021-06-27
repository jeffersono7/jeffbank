defmodule JeffBank.Transacoes.Create do
  alias JeffBank.Contas.Get
  alias JeffBank.{Conta, Transacao, Repo}
  alias Ecto.Multi

  import Ecto.Query

  def call(params, tipo) do
    params
    |> Map.put(:tipo, tipo)
    |> criar_transacao()
  end

  def estornar_transacao(%{transacao_id: transacao_id}) do
    with {:ok, transacao} <- fetch_transacao(transacao_id),
         true <- transacao_pode_ser_estornada?(transacao_id) do
      %{
        valor: transacao.valor,
        enviante_id: transacao.recebedora_id,
        recebedora_id: transacao.enviante_id,
        tipo: :estorno,
        transacao_id: transacao_id
      }
      |> criar_transacao()
    else
      false -> {:error, "Transação já foi estornada!"}
      error -> error
    end
  end

  defp criar_transacao(%{enviante_id: _, recebedora_id: _, tipo: _, valor: _} = params) do
    {:ok, enviante} = Get.call(params.enviante_id)
    {:ok, recebedora} = Get.call(params.recebedora_id)
    valor = Map.get(params, :valor)

    criar_transacao_transferencia(params, enviante, recebedora, valor)
  end

  defp criar_transacao(_params), do: {:error, "Campos obrigatórios não preenchidos!"}

  defp criar_transacao_transferencia(params, enviante, recebedora, valor) do
    multi =
      Multi.new()
      |> Multi.update(:enviante_saque_valor, Conta.saque(enviante, valor))
      |> Multi.update(:recebedora_deposito_valor, Conta.deposito(recebedora, valor))
      |> Multi.insert(:insert_transacao, Transacao.changeset(params))

    with {:ok, %{insert_transacao: insert_transacao}} <- Repo.transaction(multi) do
      {:ok, insert_transacao}
    else
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  defp fetch_transacao(transacao_id) do
    case Repo.get(Transacao, transacao_id) do
      nil -> {:error, "Transação não encontrada!"}
      transacao -> {:ok, transacao}
    end
  end

  defp transacao_pode_ser_estornada?(transacao_id) do
    query = from t in Transacao, where: t.tipo == :estorno and t.transacao_id == ^transacao_id

    not Repo.exists?(query)
  end
end

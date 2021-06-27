defmodule JeffBank.Transacoes.Create do
  alias JeffBank.Contas.Get
  alias JeffBank.{Conta, Transacao, Repo}
  alias Ecto.Multi

  def call(params, tipo) do
    params
    |> Map.put(:tipo, tipo)
    |> criar_transacao()
  end

  defp criar_transacao(params) do
    {:ok, enviante} = Get.call(params.enviante_id)
    {:ok, recebedora} = Get.call(params.recebedora_id)
    valor = Map.get(params, :valor)

    case params.tipo do
      :transacao ->
        criar_transacao_transferencia(params, enviante, recebedora, valor)

      :estorno ->
        criar_transacao_estorno(params, enviante, recebedora, valor)
    end
  end

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

  defp criar_transacao_estorno(params, enviante, recebedora, valor) do
    # TODO ver regra para estorno

    Multi.new()
    |> Multi.update(:enviante_saque_valor, Conta.saque(enviante, valor))
    |> Multi.update(:recebedora_deposito_valor, Conta.deposito(recebedora, valor))
    |> Multi.insert(:insert_transacao, Transacao.changeset(params))
    |> Repo.transaction()
  end
end

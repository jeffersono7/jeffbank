defmodule JeffBank.Contas.Get do
  @moduledoc """
  Módulo para obter conta
  """

  alias JeffBank.{Repo, Conta}

  @spec call(integer()) :: {:ok, %Conta{}} | {:error, String.t()}
  def call(id) do
    conta = Repo.get(Conta, id)

    case conta do
      nil -> {:error, "Conta não encontrada!"}
      _ -> {:ok, conta}
    end
  end
end

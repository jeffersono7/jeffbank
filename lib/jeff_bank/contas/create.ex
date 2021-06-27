defmodule JeffBank.Contas.Create do
  @moduledoc """
  Módulo para criar uma conta
  """

  alias JeffBank.{Conta, Repo}

  def call(params) do
    params
    |> Conta.changeset()
    |> Repo.insert()
  end
end

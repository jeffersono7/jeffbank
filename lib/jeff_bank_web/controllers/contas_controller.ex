defmodule JeffBankWeb.ContasController do
  use JeffBankWeb, :controller

  alias Plug.Conn
  alias JeffBank.Conta

  action_fallback JeffBankWeb.FallbackController

  def create(%Conn{} = conn, params) do
    with {:ok, %Conta{} = conta} <- JeffBank.criar_conta(params) do
      conn
      |> put_status(:created)
      |> render("create.json", conta: conta)
    end
  end

  def get_saldo(%Conn{} = conn, %{"id" => id}) do
    with {:ok, %Conta{} = conta} <- JeffBank.obter_conta(id) do
      conn
      |> put_status(:ok)
      |> render("saldo.json", saldo: conta.saldo)
    end
  end
end

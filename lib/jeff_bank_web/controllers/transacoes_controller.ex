defmodule JeffBankWeb.TransacoesController do
  use JeffBankWeb, :controller

  alias Plug.Conn

  action_fallback JeffBankWeb.FallbackController

  def create(%Conn{} = conn, params) do
    with params_normalized <- map_normalize_keys(params),
         {:ok, transacao} <- JeffBank.criar_transacao(params_normalized, :transacao) do
      conn
      |> put_status(:created)
      |> render("create.json", transacao: transacao)
    end
  end
end

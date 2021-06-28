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

  def estornar(%Conn{} = conn, params) do
    with params_normalized <- map_normalize_keys(params),
         {:ok, transacao} <- JeffBank.estornar_transacao(params_normalized) do
      conn
      |> put_status(:created)
      |> render("create.json", transacao: transacao)
    end
  end

  def pesquisar(%Conn{} = conn, %{"data_inicio" => data_inicio, "data_final" => data_fim}) do
    with transacoes <- JeffBank.pesquisar_transacoes(data_inicio, data_fim) do
      conn
      |> put_status(:ok)
      |> render("index.json", transacoes: transacoes)
    end
  end
end

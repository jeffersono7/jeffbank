defmodule JeffBankWeb.FallbackController do
  use JeffBankWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(JeffBankWeb.ErrorView)
    |> render("400.json", result: result)
  end
end

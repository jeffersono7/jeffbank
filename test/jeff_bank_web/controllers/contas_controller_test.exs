defmodule JeffBankWeb.ContasControllerTest do
  use JeffBankWeb.ConnCase, async: true

  use JeffBank.TestUtils

  describe "create/2" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "quando parâmetros válidos, deve criar uma conta", %{conn: conn} do
      saldo = Decimal.new("10.0")
      params = %{nome: "Jefferson", sobrenome: "Phoenix", cpf: @cpf, saldo: saldo}

      response =
        conn
        |> post(Routes.contas_path(conn, :create), params)
        |> json_response(:created)

      assert %{"id" => _, "inserted_at" => _, "updated_at" => _} = response
    end

    test "quando parâmetros inválidos, deve retornar error", %{conn: conn} do
      saldo = Decimal.new("10.0")
      params = %{nome: "Jefferson", sobrenome: "Phoenix", cpf: "11111111111", saldo: saldo}

      response =
        conn
        |> post(Routes.contas_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"message" => _} = response
    end
  end
end

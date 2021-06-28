defmodule JeffBankWeb.ContasControllerTest do
  use JeffBankWeb.ConnCase, async: true

  use JeffBank.TestUtils

  alias Ecto.UUID

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

  describe "get_saldo/2" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "quando conta existir, deve retornar saldo", %{conn: conn} do
      conta = criar_conta()
      saldo_expected = Decimal.to_string(conta.saldo)

      response =
        conn
        |> get(Routes.contas_path(conn, :get_saldo, conta.id))
        |> json_response(:ok)

      assert %{"saldo" => ^saldo_expected} = response
    end

    test "quando conta não existir, deve retornar error", %{conn: conn} do
      response =
        conn
        |> get(Routes.contas_path(conn, :get_saldo, UUID.generate()))
        |> json_response(:bad_request)

      assert %{"message" => "Conta não encontrada!"} = response
    end
  end
end

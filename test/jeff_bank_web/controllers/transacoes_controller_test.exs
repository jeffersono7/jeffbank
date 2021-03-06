defmodule JeffBankWeb.TransacoesControllerTest do
  use JeffBankWeb.ConnCase, async: true

  use JeffBank.TestUtils
  alias Ecto.UUID

  describe "create/2" do
    setup %{conn: conn} do
      conn = put_token_conn(conn)

      {:ok, conn: conn}
    end

    test "quando parâmetros válidos, deve fazer uma transação", %{conn: conn} do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      response =
        conn
        |> post(Routes.transacoes_path(conn, :create), params)
        |> json_response(:created)

      assert %{
               "enviante_id" => _,
               "id" => _,
               "inserted_at" => _,
               "recebedora_id" => _,
               "updated_at" => _,
               "valor" => "40.0"
             } = response
    end

    test "quando parâmetros inválidos, deve retornar error", %{conn: conn} do
      valor = Decimal.new("40.0")
      enviante = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id}

      response =
        conn
        |> post(Routes.transacoes_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"message" => "Campos obrigatórios não preenchidos!"} = response
    end
  end

  describe "estornar/2" do
    setup %{conn: conn} do
      conn = put_token_conn(conn)

      {:ok, conn: conn}
    end

    test "quando parâmetros válidos, deve criar transacao de estorno", %{conn: conn} do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      %{"id" => transacao_id} =
        conn
        |> post(Routes.transacoes_path(conn, :create), params)
        |> json_response(:created)

      response =
        conn
        |> post(Routes.transacoes_path(conn, :estornar, transacao_id))
        |> json_response(:created)

      assert %{
               "enviante_id" => _,
               "id" => _,
               "inserted_at" => _,
               "recebedora_id" => _,
               "tipo" => "estorno",
               "updated_at" => _,
               "valor" => "40.0"
             } = response
    end

    test "quando não existir transação para poder estornar, deve retornar error", %{conn: conn} do
      response =
        conn
        |> post(Routes.transacoes_path(conn, :estornar, UUID.generate()))
        |> json_response(:bad_request)

      assert %{"message" => "Transação não encontrada!"} = response
    end
  end

  describe "pesquisar/2" do
    setup %{conn: conn} do
      conn = put_token_conn(conn)

      {:ok, conn: conn}
    end

    test "deve retornar resultado da pesquisa por intervalor", %{conn: conn} do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      data_hora_antes = DateTime.utc_now()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      conn
      |> post(Routes.transacoes_path(conn, :create), params)
      |> json_response(:created)

      conn
      |> post(Routes.transacoes_path(conn, :create), params)
      |> json_response(:created)

      response =
        conn
        |> get(
          Routes.transacoes_path(conn, :pesquisar),
          data_inicio: data_hora_antes,
          data_final: DateTime.utc_now()
        )
        |> json_response(:ok)

      assert [_, _] = response
    end
  end
end

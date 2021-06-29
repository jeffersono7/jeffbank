defmodule JeffBank.TestUtils do
  @moduledoc """
  Módulo utilitário para testes
  """

  alias JeffBank.Contas.{Create, Login}
  import Plug.Conn

  @cpf "90518762033"

  defmacro __using__(_opts) do
    quote do
      @cpf unquote(@cpf)

      defdelegate criar_conta, to: unquote(__MODULE__)
      defdelegate get_token, to: unquote(__MODULE__)
      defdelegate put_token_conn(conn), to: unquote(__MODULE__)
    end
  end

  def criar_conta do
    cpf = Brcpfcnpj.cpf_generate()

    params = %{nome: "Jefferson", sobrenome: "Elixir", cpf: cpf, saldo: Decimal.new("100"), password: "123456"}

    {:ok, conta} = Create.call(params)

    conta
  end

  def get_token do
    conta = criar_conta()

    {:ok, token, _decoded} = Login.call(conta.cpf, conta.password)

    token
  end

  def put_token_conn(conn) do
    token = get_token()

    conn = conn |> put_req_header("authorization", "Bearer #{token}")

    conn
  end
end

defmodule JeffBank.TestUtils do
  @moduledoc """
  Módulo utilitário para testes
  """

  alias JeffBank.Contas.Create

  @cpf "90518762033"

  defmacro __using__(_opts) do
    quote do
      @cpf unquote(@cpf)

      defdelegate criar_conta, to: unquote(__MODULE__)
    end
  end

  def criar_conta do
    cpf = Brcpfcnpj.cpf_generate()

    params = %{nome: "Jefferson", sobrenome: "Elixir", cpf: cpf, saldo: Decimal.new("100")}

    {:ok, conta} = Create.call(params)

    conta
  end
end

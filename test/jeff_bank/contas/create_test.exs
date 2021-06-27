defmodule JeffBank.Contas.CreateTest do
  use JeffBank.DataCase, async: true
  use JeffBank.TestUtils

  alias Ecto.Changeset
  alias JeffBank.Contas.Create
  alias JeffBank.Conta

  describe "call/2" do
    test "quando parametros válidos, deve criar uma conta" do
      saldo = Decimal.new("10.0")
      params = %{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: saldo}

      assert {:ok, %Conta{}} = Create.call(params)
    end

    test "quando parametros inválidos, deve retornar error" do
      saldo = Decimal.new("10.0")
      params = %{nome: "Jefferson", sobrenome: "Farias", saldo: saldo}

      assert {:error, %Changeset{valid?: false}} = Create.call(params)
    end
  end
end

defmodule JeffBank.ContaTest do
  use ExUnit.Case, async: true

  use JeffBank.TestUtils

  alias Ecto.Changeset
  alias JeffBank.Conta

  describe "changeset/1" do
    test "quando parâmetros válidos, deve retornar um changeset válido" do
      saldo = Decimal.new("0.0")

      param = %{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: saldo}

      assert %Changeset{
               changes: %{cpf: @cpf, nome: "Jefferson", sobrenome: "Farias", saldo: ^saldo},
               valid?: true
             } = Conta.changeset(param)
    end

    test "quando parâmetros inválidos, deve retornar um changeset inválido" do
      param = %{nome: "Jefferson"}

      assert %Changeset{
               changes: %{nome: "Jefferson"},
               errors: [
                 sobrenome: {"can't be blank", [validation: :required]},
                 cpf: {"can't be blank", [validation: :required]},
                 saldo: {"can't be blank", [validation: :required]}
               ],
               valid?: false
             } = Conta.changeset(param)
    end
  end

  describe "deposito/2" do
    test "quando recebido uma conta e valor de deposito, deve retornar um changeset válido com novo saldo" do
      saldo = Decimal.new("0.0")
      conta = %Conta{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: saldo}

      valor_deposito = Decimal.new("30.0")

      saldo_expected = Decimal.add(saldo, valor_deposito)

      assert %Changeset{
               changes: %{saldo: ^saldo_expected},
               valid?: true
             } = Conta.deposito(conta, valor_deposito)
    end
  end
end

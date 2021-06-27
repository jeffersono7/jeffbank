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

  describe "saque/2" do
    test "quando recebido uma conta com saldo suficiente e valor de saque dentro do limite, deve retornar um changeset válido com novo saldo" do
      saldo = Decimal.new("100.25")
      conta = %Conta{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: saldo}

      valor_saque = Decimal.new("30.23")

      saldo_expected = Decimal.sub(saldo, valor_saque)

      assert %Changeset{
               changes: %{saldo: ^saldo_expected},
               valid?: true
             } = Conta.saque(conta, valor_saque)
    end

    test "quando recebido uma conta e valor de saque maior que o saldo existente, deve retornar um changeset inválido sem alterações" do
      saldo = Decimal.new("100.25")
      conta = %Conta{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: saldo}

      valor_saque = Decimal.new("100.26")

      saldo_expected = Decimal.sub(saldo, valor_saque)

      assert %Changeset{
               changes: %{},
               errors: [saldo: {_, [validation: :saldo_insuficiente]}],
               valid?: false
             } = Conta.saque(conta, valor_saque)
    end
  end
end

defmodule JeffBank.Transacoes.CreateTest do
  use JeffBank.DataCase, async: true
  use JeffBank.TestUtils

  alias Ecto.Changeset
  alias JeffBank.{Contas, Transacoes, Transacao}
  alias Transacoes.Create

  describe "call/2" do
    test "quando parametros válidos, deve criar uma transacao entre contas" do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      assert {:ok, %Transacao{id: _, valor: ^valor}} = Create.call(params, :transacao)

      {:ok, enviante_apos} = Contas.Get.call(enviante.id)
      {:ok, recebedora_apos} = Contas.Get.call(recebedora.id)

      assert enviante_apos.saldo == Decimal.sub(enviante.saldo, valor)
      assert recebedora_apos.saldo == Decimal.add(recebedora.saldo, valor)
    end

    test "quando houver qualquer erro durante a transacao, não deve criar uma transacao entre contas" do
      valor = Decimal.new("40000.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      assert {:error, %Changeset{valid?: false}} = Create.call(params, :transacao)

      {:ok, enviante_apos} = Contas.Get.call(enviante.id)
      {:ok, recebedora_apos} = Contas.Get.call(recebedora.id)

      assert enviante_apos.saldo == enviante.saldo
      assert recebedora_apos.saldo == recebedora.saldo
    end
  end
end

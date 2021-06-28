defmodule JeffBank.Transacoes.CreateTest do
  use JeffBank.DataCase, async: true
  use JeffBank.TestUtils

  alias Ecto.{Changeset, UUID}
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

  describe "estornar_transacao/1" do
    test "quando parâmetros válidos, deve criar uma transacao de estorno, fazendo movimentação entre as contas" do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      assert {:ok, %Transacao{id: _, valor: ^valor} = transacao} = Create.call(params, :transacao)

      assert {:ok, %Transacao{id: _, valor: ^valor}} =
               Create.estornar_transacao(%{id: transacao.id})

      {:ok, enviante_apos} = Contas.Get.call(enviante.id)
      {:ok, recebedora_apos} = Contas.Get.call(recebedora.id)

      assert Decimal.eq?(enviante_apos.saldo, enviante.saldo)
      assert Decimal.eq?(recebedora_apos.saldo, recebedora.saldo)
    end

    test "quando parâmetros transacao já estornada, não pode criar uma transacao de estorno" do
      valor = Decimal.new("40.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      assert {:ok, %Transacao{id: _, valor: ^valor} = transacao} = Create.call(params, :transacao)

      Create.estornar_transacao(%{id: transacao.id})

      assert {:error, "Transação já foi estornada!"} =
               Create.estornar_transacao(%{id: transacao.id})
    end

    test "quando tentar estar transacao que não existe, deve retornar erro" do
      assert {:error, "Transação não encontrada!"} =
               Create.estornar_transacao(%{id: UUID.generate()})
    end
  end
end

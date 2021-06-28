defmodule JeffBank.Transacoes.IndexTest do
  use JeffBank.DataCase, async: true
  use JeffBank.TestUtils

  alias JeffBank.Transacoes.{Index, Create}

  describe "pesquisar/2" do
    test "quando existir transações no intervalor, deve retorná-los" do
      valor = Decimal.new("20.0")
      enviante = criar_conta()
      recebedora = criar_conta()

      params = %{valor: valor, enviante_id: enviante.id, recebedora_id: recebedora.id}

      data_hora_antes = DateTime.utc_now()

      Create.call(params, :transacao)
      Create.call(params, :transacao)
      Create.call(params, :transacao)
      Create.call(params, :transacao)

      data_hora_depois = DateTime.utc_now()

      assert [_, _, _, _] = Index.call(data_hora_antes, data_hora_depois)
    end
  end
end

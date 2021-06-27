defmodule JeffBank.TransacaoTest do
  use ExUnit.Case, async: true

  alias Ecto.{Changeset, UUID}
  alias JeffBank.Transacao

  describe "changeset/1" do
    test "quando parametros válidos, deve retornar um changeset válido" do
      enviante_id = UUID.generate()
      recebedora_id = UUID.generate()
      valor = Decimal.new("10.0")

      params = %{
        tipo: :transacao,
        valor: valor,
        enviante_id: enviante_id,
        recebedora_id: recebedora_id
      }

      assert %Changeset{
               changes: %{
                 enviante_id: ^enviante_id,
                 recebedora_id: ^recebedora_id,
                 tipo: :transacao,
                 valor: ^valor
               },
               valid?: true
             } = Transacao.changeset(params)
    end
  end
end

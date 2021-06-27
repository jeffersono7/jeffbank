defmodule JeffBank.Contas.GetTest do
  use JeffBank.DataCase, async: true

  use JeffBank.TestUtils

  alias Ecto.UUID
  alias JeffBank.{Conta, Contas}
  alias Contas.{Create, Get}

  describe "call/1" do
    test "quando conta não existir, deve retornar error" do
      id = UUID.generate()

      assert {:error, _} = Get.call(id)
    end

    test "quando conta existir deve retornar conta" do
      {:ok, conta} =
        %{nome: "Jefferson", sobrenome: "Farias", cpf: @cpf, saldo: Decimal.new("10.0")}
        |> Create.call()

      assert {:ok, %Conta{}} = Get.call(conta.id)
    end
  end
end

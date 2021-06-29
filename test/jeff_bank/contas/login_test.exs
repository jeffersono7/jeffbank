defmodule JeffBank.Contas.LoginTest do
  use JeffBank.DataCase, async: true
  use JeffBank.TestUtils

  alias JeffBank.Contas.Login

  describe "call/2" do
    test "quando parâmetros válidos, deve retornar token jwt" do
      conta = criar_conta()

      assert {:ok, _jwt} = Login.call(conta.cpf, "123456")
    end
  end
end

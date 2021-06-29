defmodule JeffBankWeb.ContasView do
  use JeffBankWeb, :view

  alias JeffBank.Conta

  def render("create.json", %{
        conta: %Conta{
          id: id,
          cpf: cpf,
          nome: nome,
          sobrenome: sobrenome,
          saldo: saldo,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      id: id,
      cpf: cpf,
      nome: nome,
      sobrenome: sobrenome,
      saldo: saldo,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  def render("saldo.json", %{saldo: saldo}) do
    %{saldo: saldo}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end

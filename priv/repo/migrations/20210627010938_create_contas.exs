defmodule JeffBank.Repo.Migrations.CreateContas do
  use Ecto.Migration

  def change do
    create table(:contas) do
      add :nome, :string, not_null: true, size: 20
      add :sobrenome, :string, not_null: true, size: 50
      add :cpf, :string, not_null: true, size: 11
      add :saldo, :decimal, not_null: true

      timestamps()
    end
  end
end

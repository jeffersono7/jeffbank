defmodule JeffBank.Repo.Migrations.CreateContas do
  use Ecto.Migration

  def change do
    create table(:contas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nome, :string, not_null: true, size: 20
      add :sobrenome, :string, not_null: true, size: 50
      add :cpf, :string, not_null: true, size: 11
      add :saldo, :decimal, not_null: true
      add :password_hash, :string, not_null: true, size: 1000

      timestamps()
    end

    create unique_index(:contas, [:cpf])
  end
end

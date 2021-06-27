defmodule JeffBank.Repo.Migrations.CreateTransacoes do
  use Ecto.Migration

  def change do
    create table(:transacoes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :valor, :decimal, not_null: true
      add :tipo, :string, not_null: true, size: 20
      add :enviante_id, references(:contas, on_delete: :nothing, type: :binary_id), not_null: true
      add :recebedora_id, references(:contas, on_delete: :nothing, type: :binary_id), not_null: true

      timestamps()
    end

    create index(:transacoes, [:enviante_id])
    create index(:transacoes, [:recebedora_id])
  end
end

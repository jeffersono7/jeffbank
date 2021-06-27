defmodule JeffBank.Conta do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contas" do
    field :cpf, :string
    field :nome, :string
    field :saldo, :decimal
    field :sobrenome, :string

    timestamps()
  end

  @doc false
  def changeset(conta, attrs) do
    conta
    |> cast(attrs, [:nome, :sobrenome, :cpf, :saldo])
    |> validate_required([:nome, :sobrenome, :cpf, :saldo])
  end
end
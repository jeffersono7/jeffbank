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
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:nome, :sobrenome, :cpf, :saldo])
    |> validate_required([:nome, :sobrenome, :cpf, :saldo])
  end

  @spec deposito(%__MODULE__{}, Decimal.t()) :: Ecto.Changeset.t()
  def deposito(%{saldo: saldo} = conta, valor) do
    novo_saldo = %{saldo: Decimal.add(saldo, valor)}

    conta
    |> cast(novo_saldo, [:saldo])
    |> validate_required([:saldo])
  end
end

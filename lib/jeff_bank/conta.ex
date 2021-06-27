defmodule JeffBank.Conta do
  @moduledoc """
  Módulo de Conta
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset

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
    |> validate_cpf(:cpf)
    |> unique_constraint(:cpf)
  end

  @spec deposito(%__MODULE__{}, Decimal.t()) :: Ecto.Changeset.t()
  def deposito(%{saldo: saldo} = conta, valor) do
    novo_saldo = %{saldo: Decimal.add(saldo, valor)}

    conta
    |> cast(novo_saldo, [:saldo])
    |> validate_required([:saldo])
  end

  @spec saque(%__MODULE__{}, Decimal.t()) :: Ecto.Changeset.t()
  def saque(%{saldo: saldo} = conta, valor) do
    novo_saldo = %{saldo: Decimal.sub(saldo, valor)}

    case Decimal.negative?(novo_saldo.saldo) do
      true ->
        conta
        |> cast(%{}, [])
        |> add_error(:saldo, "Saldo insuficiente!", validation: :saldo_insuficiente)

      false ->
        conta
        |> cast(novo_saldo, [:saldo])
        |> validate_required([:saldo])
    end
  end
end

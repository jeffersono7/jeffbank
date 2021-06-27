defmodule JeffBank.Transacao do
  @moduledoc """
  Módulo para transações entre contas
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transacoes" do
    field :tipo, Ecto.Enum, values: [:transacao, :estorno]
    field :valor, :decimal

    belongs_to :enviante, JeffBank.Conta
    belongs_to :recebedora, JeffBank.Conta

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:valor, :tipo, :enviante_id, :recebedora_id])
    |> validate_required([:valor, :tipo, :enviante_id, :recebedora_id])
    |> validate_inclusion(:tipo, Ecto.Enum.values(__MODULE__, :tipo))
    |> foreign_key_constraint(:enviante_id)
    |> foreign_key_constraint(:recebedora_id)
    |> validate_number(:valor, greater_than: 0)
  end
end

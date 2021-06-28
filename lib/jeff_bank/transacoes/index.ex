defmodule JeffBank.Transacoes.Index do
  alias JeffBank.{Transacao, Repo}
  import Ecto.Query, only: [from: 2]

  def call(data_inicio, data_fim) do
    query = from t in Transacao, where: t.inserted_at >= ^data_inicio and t.inserted_at <= ^data_fim

    Repo.all(query)
  end
end

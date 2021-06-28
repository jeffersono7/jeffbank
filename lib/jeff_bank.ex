defmodule JeffBank do
  @moduledoc """
  JeffBank keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias JeffBank.{Contas, Transacoes}

  defdelegate criar_conta(params), to: Contas.Create, as: :call
  defdelegate criar_transacao(params, tipo), to: Transacoes.Create, as: :call
  defdelegate estornar_transacao(params), to: Transacoes.Create
  defdelegate pesquisar_transacoes(data_inicio, data_fim), to: Transacoes.Index, as: :call
end

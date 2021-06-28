defmodule JeffBankWeb.TransacoesView do
  use JeffBankWeb, :view

  alias JeffBank.Transacao

  def render("create.json", %{
        transacao: %Transacao{
          id: id,
          valor: valor,
          enviante_id: enviante_id,
          recebedora_id: recebedora_id,
          tipo: tipo,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      id: id,
      valor: valor,
      enviante_id: enviante_id,
      recebedora_id: recebedora_id,
      tipo: tipo,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  def render("index.json", %{transacoes: transacoes}) do
    transacoes
    |> Enum.map(&render("create.json", transacao: &1))
  end
end

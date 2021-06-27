defmodule JeffBankWeb.TransacoesView do
  use JeffBankWeb, :view

  alias JeffBank.Transacao

  def render("create.json", %{
        transacao: %Transacao{
          id: id,
          valor: valor,
          enviante_id: enviante_id,
          recebedora_id: recebedora_id,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      id: id,
      valor: valor,
      enviante_id: enviante_id,
      recebedora_id: recebedora_id,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end
end

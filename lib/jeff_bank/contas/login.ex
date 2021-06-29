defmodule JeffBank.Contas.Login do
  alias JeffBank.{Repo, Conta, Guardian}

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def call(cpf, password) do
    case Repo.get_by(Conta, cpf: cpf) do
      nil ->
        dummy_checkpw()
        {:error, "Conta ou senha inválida!"}

      conta ->
        gerar_token(conta, password)
    end
  end

  def gerar_token(conta, password) do
    if checkpw(password, conta.password_hash) do
      {:ok, Guardian.encode_and_sign(conta)}
    else
      {:error, "Conta ou senha inválida"}
    end
  end
end

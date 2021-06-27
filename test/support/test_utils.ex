defmodule JeffBank.TestUtils do
  @moduledoc """
  Módulo utilitário para testes
  """

  @cpf "90518762033"

  defmacro __using__(_opts) do
    quote do
      @cpf unquote(@cpf)
    end
  end
end

defmodule JeffBank.Guardian do
  use Guardian, otp_app: :jeff_bank

  def subject_for_token(conta, _claims) do
    sub = to_string(conta.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    JeffBank.Contas.Get.call(id)
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end

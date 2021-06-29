defmodule JeffBankWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :jeff_bank,
    module: JeffBank.Guardian,
    error_handler: JeffBankWeb.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end

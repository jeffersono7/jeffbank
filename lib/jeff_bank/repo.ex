defmodule JeffBank.Repo do
  use Ecto.Repo,
    otp_app: :jeff_bank,
    adapter: Ecto.Adapters.Postgres
end

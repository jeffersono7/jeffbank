# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jeff_bank,
  ecto_repos: [JeffBank.Repo]

# Config generators
config :jeff_bank, :generators,
  migration: true,
  binary_id: true

config :jeff_bank, JeffBank.Guardian,
  issuer: "JeffBank",
  secret_key: "c1WBhAHuKOIvwGPyq60B8QtEZyfMVG380oUguLuIs1cPwivnNhuWAvTSChEa++he"

# Configures the endpoint
config :jeff_bank, JeffBankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "11k3RCNYesXMXJeR2e9tFTVqHABsLFGAtVV9BreltarpzUPb+nBP/t3T7Q1S8eWH",
  render_errors: [view: JeffBankWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: JeffBank.PubSub,
  live_view: [signing_salt: "dTRLtpi8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

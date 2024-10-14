# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :time_manager,
  ecto_repos: [TimeManager.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :time_manager, TimeManagerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: TimeManagerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TimeManager.PubSub,
  live_view: [signing_salt: "Ck9/b/nZ"]

# Configures the mailer
config :time_manager, TimeManager.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# JWT Configuration for Joken
config :joken,
  default_signer: %{
    alg: "HS256",
    key: System.get_env("SECRET_KEY_BASE") || "Nzlddl2xEmLt6mAxR4yT+3R4MNUiiKAeGdSlObI0H1pdAVrfQErlV3Oak1Kj4Ku4"
  }

# Import environment-specific config.
import_config "#{config_env()}.exs"

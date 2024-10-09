import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: TimeManager.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Configures the database connection for production
config :time_manager, TimeManager.Repo,
  url: System.get_env("DATABASE_URL"),
  ssl: [
    verify: :verify_peer,
    cacertfile: "/path/to/ca-certificates.crt"
  ],
  pool_size: 10

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

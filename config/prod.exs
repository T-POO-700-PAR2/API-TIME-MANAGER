import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: TimeManager.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Configures the database connection for production
config :time_manager, TimeManager.Repo,
  # Utilise l'URL de la base de données définie dans Heroku
  url: System.get_env("DATABASE_URL"),
  # Active le SSL pour la connexion à la base de données
  ssl: true,
  # Assurez-vous que l'option ssl_opts utilise la sécurité correcte
  ssl_opts: [verify: :verify_none],
  # Pool de connexions
  pool_size: 10

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

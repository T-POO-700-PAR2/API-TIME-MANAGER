use Mix.Config

# Configuration de votre base de données
config :time_manager, TimeManager.Repo,
  username: System.get_env("DATABASE_USER") || "postgres",
  password: System.get_env("DATABASE_PASSWORD") || "postgres",
  database: System.get_env("DATABASE_NAME") || "time_manager_db",
  hostname: System.get_env("DATABASE_HOST") || "localhost",
  pool_size: 10,
  ssl: System.get_env("DATABASE_SSL") == "true"  # Active SSL si nécessaire

# Configuration pour l'endpoint Phoenix
config :time_manager, TimeManagerWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.get_env("E2pNhWS6IqpMUNywMSFkXv4hHr9/g3J+QJSAriKLO70nQpHpO9rqNyqPjdVYXVbI")

# Log level en production
config :logger, level: :info

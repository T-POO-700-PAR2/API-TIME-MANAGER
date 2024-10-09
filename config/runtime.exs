import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.

if System.get_env("PHX_SERVER") do
  config :time_manager, TimeManagerWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

  config :time_manager, TimeManager.Repo,
    ssl: true, # Activation de SSL pour sécuriser la connexion à la base de données
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6

  # The secret key base is used to sign/encrypt cookies and other secrets.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "time-manager-par2.herokuapp.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :time_manager, TimeManagerWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0}, # Support IPv6 pour compatibilité réseau
      port: port
    ],
    secret_key_base: secret_key_base

  # Forcer l'utilisation de SSL et rediriger le trafic HTTP vers HTTPS
  config :time_manager, TimeManagerWeb.Endpoint,
    force_ssl: [hsts: true]

  # Configuration SSL optionnelle
  # Uncomment and configure if you have a custom SSL certificate:
  #
  # config :time_manager, TimeManagerWeb.Endpoint,
  #   https: [
  #     port: 443,
  #     cipher_suite: :strong,
  #     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
  #     certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
  #   ]

  # Configurer Swoosh pour l'envoi de mails en production
  # config :time_manager, TimeManager.Mailer,
  #   adapter: Swoosh.Adapters.Mailgun,
  #   api_key: System.get_env("MAILGUN_API_KEY"),
  #   domain: System.get_env("MAILGUN_DOMAIN")
end

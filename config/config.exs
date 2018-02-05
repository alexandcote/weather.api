use Mix.Config

alias Weather.Authentication

# General application configuration
config :weather, ecto_repos: [Weather.Repo]

# Configures the endpoint
config :weather, WeatherWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT")],
  url: [host: System.get_env("BASE_URL"), port: System.get_env("PORT")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: WeatherWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Weather.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure your database
config :weather, Weather.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("POSTGRES_HOST"),
  database: System.get_env("POSTGRES_DB"),
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  pool_size: String.to_integer(System.get_env("POSTGRES_POOL_SIZE") || "10")

config :weather, Authentication.Guardian,
  issuer: "weather",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :weather, Authentication.Pipeline,
  module: Authentication.Guardian,
  error_handler: Authentication.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

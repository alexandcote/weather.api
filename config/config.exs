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

config :weather, Weather.Connection,
  database: System.get_env("INFLUXDB_DB"),
  host: System.get_env("INFLUXDB_DB_HOST"),
  username: System.get_env("INFLUXDB_USER"),
  password: System.get_env("INFLUXDB_USER_PASSWORD"),
  pool: [max_overflow: 10, size: 1],
  port: String.to_integer(System.get_env("INFLUXDB_DB_PORT") || "8086"),
  scheme: "http",
  http_opts: [insecure: true],
  writer: Instream.Writer.Line

config :weather, Authentication.Guardian,
  issuer: "weather",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :weather, Authentication.Pipeline,
  module: Authentication.Guardian,
  error_handler: Authentication.ErrorHandler

config :cors_plug,
  origin: [{:system, "APP_DOMAIN", "*"}],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [
      app: :weather,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Weather.Application, []},
      extra_applications: [:logger, :runtime_tools, :instream]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # HTTP
      {:cowboy, "~> 1.0"},

      # Phoenix
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:poison, "~> 3.1.0"},
      {:gettext, "~> 0.11"},
      {:cors_plug, "~> 1.2"},

      # Database
      {:postgrex, ">= 0.0.0"},
      {:instream,
       git: "https://github.com/mneudert/instream.git",
       ref: "324bc60ae4ddc8599fc0e7a63b48ee9a9c7b78e9"},

      # GraphQL
      {:absinthe, "~> 1.4.0"},
      {:absinthe_plug, "~> 1.4.0"},

      # Authentification
      {:guardian, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:pbkdf2_elixir, "~> 0.12"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

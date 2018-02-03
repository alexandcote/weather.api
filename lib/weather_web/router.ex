defmodule WeatherWeb.Router do
  use WeatherWeb, :router

  # Aliases
  alias WeatherGraph.Schema
  alias WeatherWeb.{Plugs, DataController, UserSocket}

  # Pipelines
  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :graphql do
    plug(:accepts, ["json"])

    plug(Plugs.Context)
  end

  scope "/api" do
    pipe_through(:api)

    resources "/datas", DataController, only: [:create]
  end

  scope "/graphql" do
    pipe_through(:graphql)

    forward(
      "/",
      Absinthe.Plug,
      schema: Schema,
      socket: UserSocket
    )
  end

  with :dev <- Mix.env() do
    scope "/graphiql" do
      pipe_through(:graphql)

      forward(
        "/",
        Absinthe.Plug.GraphiQL,
        schema: Schema,
        socket: UserSocket,
        interface: :advanced
      )
    end
  end
end

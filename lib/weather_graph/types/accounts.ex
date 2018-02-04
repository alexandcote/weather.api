defmodule WeatherGraph.Types.Accounts do
  use Absinthe.Schema.Notation

  alias WeatherGraph.Resolvers

  @desc "A user of the application"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :stations, list_of(:station) do
      resolve &Resolvers.Stations.list_my_stations/2
    end
  end

  @desc "The user session"
  object :session do
    field :token, :string
  end

  @desc "The user input"
  input_object :user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end

end

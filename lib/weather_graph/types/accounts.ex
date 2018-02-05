defmodule WeatherGraph.Types.Accounts do
  use Absinthe.Schema.Notation

  alias WeatherGraph.Resolvers

  @desc "A user of the application"
  object :user do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:email, non_null(:string))

    field :stations, list_of(:station) do
      resolve(&Resolvers.Stations.list_my_stations/2)
    end
  end

  @desc "The user session"
  object :session do
    field(:token, non_null(:string))
  end

  @desc "The create user input"
  input_object :create_user_input do
    field(:name, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end

  @desc "The update user input"
  input_object :update_user_input do
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)
  end
end

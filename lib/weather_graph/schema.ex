defmodule WeatherGraph.Schema do
  use Absinthe.Schema

  # Aliases
  alias WeatherGraph.Middlewares
  alias WeatherGraph.Resolvers
  alias WeatherGraph.Types.Stations
  alias WeatherGraph.Types.Accounts

  # Types
  import_types(Stations)
  import_types(Accounts)

  query do
    @desc "Get my information"
    field :me, type: non_null(:user) do
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.me/2)
    end

    @desc "Get the list of stations"
    field :stations, list_of(:station) do
      resolve(&Resolvers.Stations.list_stations/2)
    end

    @desc "Get a station"
    field :station, type: non_null(:station) do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Stations.find_station/2)
    end

    @desc "Get a data record"
    field :data, type: non_null(:data) do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Stations.find_data/2)
    end
  end

  mutation do
    @desc "Create a user"
    field :create_user, type: non_null(:user) do
      arg(:user, non_null(:create_user_input))

      resolve(&Resolvers.Accounts.create_user/3)
    end

    @desc "Login for a user"
    field :login, type: non_null(:session) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.login/3)
    end

    @desc "Update a user"
    field :update_profile, type: non_null(:user) do
      arg(:user, :update_user_input)

      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.update_profile/3)
    end

    @desc "Create a station"
    field :create_station, type: non_null(:station) do
      arg(:station, non_null(:station_params))

      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Stations.create_station/3)
    end
  end
end

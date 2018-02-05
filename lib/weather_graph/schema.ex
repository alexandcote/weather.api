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
    field :me, type: :user do
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.me/2)
    end

    @desc "Get the list of stations"
    field :stations, list_of(:station) do
      resolve(&Resolvers.Stations.list_stations/2)
    end

    @desc "Get the list of stations"
    field :station, type: :station do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Stations.find_station/2)
    end

    @desc "Get a data record"
    field :data, type: :data do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Stations.find_data/2)
    end
  end

  mutation do
    field :create_user, type: :user do
      arg(:user, :user_params)

      resolve(&Resolvers.Accounts.create_user/3)
    end

    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.login/3)
    end

    field :update_profile, type: :user do
      arg(:user, :user_params)

      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.update_profile/3)
    end

    field :create_station, type: :station do
      arg(:station, :station_params)

      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Stations.create_station/3)
    end
  end
end

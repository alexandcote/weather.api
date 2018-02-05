defmodule WeatherGraph.Resolvers.Stations do
  alias Weather.Stations

  def list_stations(_args, _info) do
    {:ok, Stations.list_stations()}
  end

  def list_my_stations(_args, %{context: %{current_user: user}}) do
    {:ok, Stations.list_stations_for_user(user)}
  end

  def find_station(%{id: id}, _info) do
    case Stations.find_station(id) do
      nil -> {:error, "Station id #{id} was not found"}
      data -> {:ok, data}
    end
  end

  def create_station(_parent, %{station: station}, %{context: %{current_user: user}}) do
    station
    |> Map.put(:owner_id, user.id)
    |> Stations.create_station()
  end

  def list_datas(_args, _info) do
    {:ok, Stations.list_datas()}
  end

  def find_data(%{id: id}, _info) do
    case Stations.find_data(id) do
      nil -> {:error, "Data id #{id} was not found"}
      data -> {:ok, data}
    end
  end

  # TODO replace this with a dataloader
  # https://github.com/absinthe-graphql/absinthe/blob/master/guides/ecto.md
  def current_data(station, _args, _info) do
    case Stations.current_data_of_station(station) do
      data -> {:ok, data}
    end
  end
end

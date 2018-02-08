defmodule Weather.Stations do
  @moduledoc """
  The Stations context.
  """

  import Ecto.Query, warn: false

  alias Weather.Repo
  alias Weather.Stations.Station
  alias Weather.Connection

  @doc """
  Returns the list of stations.
  """
  def list_stations do
    Station
    |> order_by(:name)
    |> Repo.all()
  end

  @doc """
  Returns the list of stations.
  """
  def list_stations_for_user(user) do
    Station
    |> where(owner_id: ^user.id)
    |> order_by(:name)
    |> Repo.all()
  end

  @doc """
  Gets a single station.
  """
  def find_station(id), do: Repo.get(Station, id)

  @doc """
  Creates a station.
  """
  def create_station(attrs \\ %{}) do
    %Station{}
    |> Station.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a station.
  """
  def update_station(%Station{} = station, attrs) do
    station
    |> Station.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Station.
  """
  def delete_station(%Station{} = station) do
    Repo.delete(station)
  end

  @doc """
  Returns the list of datas for a station.
  """
  def list_datas(station) do
    query = "SELECT * FROM \"datas\" WHERE \"station_id\" = '#{station.id}' ORDER BY time DESC"

    with %{results: [%{series: [data | _]} | _]} <- Connection.query(query) do
      columns = Enum.map(data.columns, fn(x) -> String.to_atom(x) end)

      data.values
      |> Enum.map(fn(values) -> parse_data(columns, values) end)
    end
  end

  @doc """
  Returns the current data of a station
  """
  def current_data(station) do
    query = "SELECT * FROM \"datas\" WHERE \"station_id\" = '#{station.id}' ORDER BY time DESC LIMIT 1"

    with %{results: [%{series: [data | _]} | _]} <- Connection.query(query) do
      values = List.first(data.values)
      columns = Enum.map(data.columns, fn(x) -> String.to_atom(x) end)
      parse_data(columns, values)
    end
  end

  def parse_data(col, val) do
    [col, val]
    |> List.zip
    |> Map.new
  end
end
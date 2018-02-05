defmodule Weather.Stations do
  @moduledoc """
  The Stations context.
  """

  import Ecto.Query, warn: false

  alias Weather.Repo
  alias Weather.Stations.{Station, Data}

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
  Returns the list of datas.
  """
  def list_datas do
    Data
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Returns the list of datas for a station.
  """
  def list_datas_of_station(station) do
    Data
    |> where(station_id: ^station.id)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single data.
  """
  def find_data(id), do: Repo.get(Data, id)

  @doc """
  Returns the current data of a station
  """
  def current_data_of_station(station) do
    Data
    |> where(station_id: ^station.id)
    |> order_by(desc: :inserted_at)
    |> first
    |> Repo.one()
  end

  @doc """
  Creates a data.
  """
  def create_data(attrs \\ %{}) do
    %Data{}
    |> Data.changeset(attrs)
    |> Repo.insert()
  end
end

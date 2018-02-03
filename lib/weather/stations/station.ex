defmodule Weather.Stations.Station do
  use Ecto.Schema
  import Ecto.Changeset
  alias Weather.Stations.Station


  schema "stations" do

    timestamps()
  end

  @doc false
  def changeset(%Station{} = station, attrs) do
    station
    |> cast(attrs, [])
    |> validate_required([])
  end
end

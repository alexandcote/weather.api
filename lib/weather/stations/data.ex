defmodule Weather.Stations.Data do
  use Ecto.Schema

  import Ecto.Changeset

  @moduledoc """
  The plain and simple `Data` model
  """

  schema "datas" do
    field(:barometer, :float)
    field(:in_temperature, :float)
    field(:out_temperature, :float)
    field(:in_humidity, :integer)
    field(:out_humidity, :integer)
    field(:rain_rate, :float)
    field(:ten_min_wind_speed, :float)
    field(:wind_direction, :float)
    field(:wind_speed, :integer)

    timestamps()
  end

  @required_fields ~w(
    barometer
    in_temperature
    out_temperature
    in_humidity
    out_humidity
    rain_rate
    ten_min_wind_speed
    wind_direction
    wind_speed
  )a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
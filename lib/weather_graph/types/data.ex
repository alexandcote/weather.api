defmodule WeatherGraph.Types.Data do
  use Absinthe.Schema.Notation

  @desc "A data in the platform"
  object :data do
    field(:id, :id)
    field(:barometer, :float)
    field(:in_temperature, :float)
    field(:out_temperature, :float)
    field(:in_humidity, :integer)
    field(:out_humidity, :integer)
    field(:rain_rate, :float)
    field(:ten_min_wind_speed, :float)
    field(:wind_direction, :float)
    field(:wind_speed, :integer)
  end

end
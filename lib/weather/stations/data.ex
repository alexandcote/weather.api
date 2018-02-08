defmodule Weather.Stations.Data do
  use Instream.Series

  series do
    measurement("datas")

    tag(:station_id)

    field(:barometer)
    field(:bar_trend)
    field(:in_temperature)
    field(:out_temperature)
    field(:in_humidity)
    field(:out_humidity)
    field(:rain_rate)
    field(:ten_min_wind_speed)
    field(:wind_direction)
    field(:wind_speed)
  end
end

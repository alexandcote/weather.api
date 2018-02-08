defmodule Weather.Stations.Data do
  use Instream.Series

  series do
    measurement("datas_2")

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
    field(:uv)
    field(:solar_radiation)
    field(:storm_rain)
    field(:start_date_storm)
    field(:day_rain)
    field(:month_rain)
    field(:year_rain)
    field(:day_et)
    field(:month_et)
    field(:year_et)
    field(:inside_alarm)
    field(:rain_alarm)
    field(:outside_alarm)
    field(:transmitter_battery)
    field(:console_battery)
    field(:forecast_icon)
    field(:forecast_rule_number)
    field(:time_of_sunrise)
    field(:time_of_sunset)
  end
end

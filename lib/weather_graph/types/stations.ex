defmodule WeatherGraph.Types.Stations do
  use Absinthe.Schema.Notation

  alias WeatherGraph.Resolvers

  @desc "A station in the application"
  object :station do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :current, type: :data do
      resolve(&Resolvers.Stations.current_data/3)
    end

    field :datas, list_of(:data) do
      resolve(&Resolvers.Stations.list_datas/3)
    end
  end

  @desc "A data of a station"
  object :data do
    field(:id, :id)
    field(:barometer, non_null(:float))
    field(:in_temperature, non_null(:float))
    field(:out_temperature, non_null(:float))
    field(:in_humidity, non_null(:integer))
    field(:out_humidity, non_null(:integer))
    field(:rain_rate, non_null(:float))
    field(:ten_min_wind_speed, non_null(:float))
    field(:wind_direction, non_null(:float))
    field(:wind_speed, non_null(:integer))
  end

  @desc "The Station input"
  input_object :station_params do
    field(:name, non_null(:string))
  end
end

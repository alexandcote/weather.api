defmodule WeatherGraph.Types.Stations do
  use Absinthe.Schema.Notation

  alias WeatherGraph.Resolvers

  @desc "A station in the application"
  object :station do
    field(:id, :id)
    field(:name, :string)

    field :current, type: :data do
      resolve(&Resolvers.Stations.current_data/3)
    end

    field :datas, list_of(:data) do
      #      arg :date, :date
      resolve(&Resolvers.Stations.list_datas/2)
    end
  end

  @desc "A data of a station"
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

  @desc "The Station input"
  input_object :station_params do
    field(:name, :string)
  end
end

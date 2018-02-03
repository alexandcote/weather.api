defmodule WeatherGraph.Schema do
  use Absinthe.Schema

  # Aliases
  alias WeatherGraph.Resolvers
  alias WeatherGraph.Types.{
    Data
  }

  # Types
  import_types(Data)

  query do
    @desc "Get the list of datas record"
    field :datas, list_of(:data) do
      resolve(&Resolvers.Data.all/2)
    end

    @desc "Get a data record"
    field :data, type: :data do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Data.find/2)
    end
  end
end
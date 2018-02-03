defmodule WeatherGraph.Resolvers.Data do
  alias Weather.Repo
  alias Weather.{Stations}

  def all(_args, _info) do
    {:ok, Stations.list_datas()}
  end

  def find(%{id: id}, _info) do
    case Stations.get_data!(id) do
      nil -> {:error, "Data id #{id} was not found"}
      data -> {:ok, data}
    end
  end
end
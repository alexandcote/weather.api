defmodule Weather.Stations do
  @moduledoc """
  """

  # Aliases
  alias Weather.Repo
  alias Weather.Stations.Data

  @doc """
  Retrive data
  """
  def get_data!(id), do: Repo.get!(Data, id)

  @doc """
  Retrive all datas
  """
  def list_datas do
    Data
    |> Repo.all()
  end

  @doc """
  Create data
  """
  def create_data(attrs \\ %{}) do
    %Data{}
    |> Data.changeset(attrs)
    |> Repo.insert()
  end
end

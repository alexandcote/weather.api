defmodule WeatherWeb.DataController do
  use WeatherWeb, :controller

  alias Weather.Stations
  alias Weather.Stations.Data

  action_fallback(WeatherWeb.FallbackController)

  def create(conn, %{"data" => data_params, "station_id" => station_id}) do
    params =
      data_params
      |> Map.put("station_id", station_id)

    with {:ok, %Data{} = data} <- Stations.create_data(params) do
      conn
      |> put_status(:created)
      |> render("show.json", data: data)
    end
  end
end

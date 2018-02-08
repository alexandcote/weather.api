defmodule WeatherGraph.Middlewares.Authentication do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.context do
      %{current_user: _} -> resolution
      _ -> Absinthe.Resolution.put_result(resolution, {:error, "Unauthenticated user"})
    end
  end
end

defmodule WeatherWeb.Plugs.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    conn
    |> add_to_context(conn)
  end

  defp add_to_context(_, conn) do
    put_private(conn, :absinthe, %{
      context: %{
        metadata: parse_metadata(conn)
      }
    })
  end

  defp parse_metadata(%{remote_ip: ip_address}) do
    %{
      ip_address: ip_address |> Tuple.to_list() |> Enum.join(".")
    }
  end
end
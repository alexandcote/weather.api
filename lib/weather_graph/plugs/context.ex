defmodule WeatherGraph.Plugs.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    put_private(conn, :absinthe, %{context: context})
  end

  def build_context(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user -> %{current_user: user}
    end
  end
end
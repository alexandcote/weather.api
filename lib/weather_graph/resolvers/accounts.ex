defmodule WeatherGraph.Resolvers.Accounts do
  alias Weather.Accounts
  alias Weather.Authentication.Guardian

  def create_user(_parent, %{user: user}, _context) do
    Accounts.create_user(user)
  end

  def login(_parent, %{email: email, password: password}, _context) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    else
      {:error, _} -> {:error, "Incorrect login credentials"}
    end
  end

  def me(_args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def update_profile(_parent, %{user: data}, %{context: %{current_user: user}}) do
    Accounts.update_user(user, data)
  end
end

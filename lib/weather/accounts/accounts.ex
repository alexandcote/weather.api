defmodule Weather.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Weather.Repo

  alias Weather.Accounts.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  """
  def find_user(id), do: Repo.get(User, id)

  @doc """
  Gets a single user.
  """
  def find_user_by_email(email) do
    User
    |> Repo.get_by(email: email)
  end

  @doc """
  Authenticate a user.
  """
  def authenticate_user(email, password) do
    user = find_user_by_email(String.downcase(email))
    with {:error, _} <- Comeonin.Pbkdf2.check_pass(user, password) do
      {:error, "Incorrect login credentials"}
    end
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end

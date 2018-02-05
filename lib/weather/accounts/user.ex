defmodule Weather.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Weather.Stations.Station

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    has_many(:stations, Station, foreign_key: :owner_id)

    timestamps()
  end

  @required_fields ~w(name email)a

  @doc false
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash()
  end

  @doc false
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password | @required_fields])
    |> validate_required([:password | @required_fields])
    |> put_pass_hash()
  end

  @doc false
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Pbkdf2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end

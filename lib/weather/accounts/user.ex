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

  @doc false
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email], [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash()
  end

  @doc false
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash()
  end

  @doc false
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    change(changeset, Comeonin.Pbkdf2.add_hash(pass))
  end

  defp put_pass_hash(changeset), do: changeset
end

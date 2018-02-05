defmodule Weather.Stations.Station do
  use Ecto.Schema
  import Ecto.Changeset

  alias Weather.Accounts.User
  alias Weather.Stations.{Data, Station}

  schema "stations" do
    field(:name, :string)

    belongs_to(:owner, User, foreign_key: :owner_id)
    has_many(:datas, Data)

    timestamps()
  end

  @required_fields ~w(name owner_id)a

  @doc false
  def changeset(%Station{} = station, attrs) do
    station
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end

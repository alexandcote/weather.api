defmodule Weather.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do

      timestamps()
    end

  end
end

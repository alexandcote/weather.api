defmodule Weather.Repo.Migrations.CreateDatas do
  use Ecto.Migration

  def change do
    create table(:datas) do
      add :barometer, :float, null: false
      add :in_temperature, :float, null: false
      add :out_temperature, :float, null: false
      add :in_humidity, :integer, null: false
      add :out_humidity, :integer, null: false
      add :rain_rate, :float, null: false
      add :ten_min_wind_speed, :float, null: false
      add :wind_direction, :float, null: false
      add :wind_speed, :integer, null: false
      add :station_id, references(:stations, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:datas, [:station_id])
  end
end

defmodule Weather.Repo.Migrations.CreateData do
  use Ecto.Migration

  def change do
    create table(:datas) do
      add :barometer, :float
      add :in_temperature, :float
      add :out_temperature, :float
      add :in_humidity, :integer
      add :out_humidity, :integer
      add :rain_rate, :float
      add :ten_min_wind_speed, :float
      add :wind_direction, :float
      add :wind_speed, :integer

      timestamps()
    end
  end
end

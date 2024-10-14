defmodule TimeManager.Repo.Migrations.CreatePlugs do
  use Ecto.Migration

  def change do
    create table(:plugs) do
      add :auth_plug, :string

      timestamps(type: :utc_datetime)
    end
  end
end

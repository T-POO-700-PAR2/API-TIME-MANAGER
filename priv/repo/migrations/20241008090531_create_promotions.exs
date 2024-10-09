defmodule TimeManager.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :promote, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end

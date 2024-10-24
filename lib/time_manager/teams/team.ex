defmodule TimeManager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    many_to_many :users, TimeManager.Accounts.User, join_through: "teams_users"
    timestamps()
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:users, required: false)
  end
end

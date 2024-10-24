defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :role, :string
    many_to_many :teams, TimeManager.Teams.Team, join_through: "teams_users"
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email])
  end
end

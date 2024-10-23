defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User

  schema "users" do
    field :username, :string
    field :role, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email, :role])
  end

  @doc """
  Récupère un utilisateur par son email.
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end

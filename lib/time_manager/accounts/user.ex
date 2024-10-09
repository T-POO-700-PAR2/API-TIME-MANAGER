defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string
    field :email, :string

    # Relation vers les clocks
    has_many :clocks, TimeManager.Clocks.Clock, on_delete: :delete_all

    # Relation vers les working_times (ajout de cette relation)
    has_many :working_times, TimeManager.TimeTracking.WorkingTime, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email, :role])
    |> foreign_key_constraint(:clocks, name: :clocks_user_id_fkey)
    |> foreign_key_constraint(:working_times, name: :working_times_user_id_fkey)  # Ajout de la contrainte
  end
end

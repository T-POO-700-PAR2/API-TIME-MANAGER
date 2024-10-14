defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  # Assurez-vous d'avoir Bcrypt pour le hachage des mots de passe
  alias Bcrypt

  schema "users" do
    field :username, :string
    field :role, :string
    field :email, :string
    # Ajout du champ pour le hachage du mot de passe
    field :password_hash, :string
    # Champ virtuel pour le mot de passe
    field :password, :string, virtual: true

    # Relation vers les clocks
    has_many :clocks, TimeManager.Clocks.Clock, on_delete: :delete_all

    # Relation vers les working_times
    has_many :working_times, TimeManager.TimeTracking.WorkingTime, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password])
    |> validate_required([:username, :email, :role])
    # Ajout d'une validation pour le mot de passe
    |> validate_length(:password, min: 6)
    # Assurez-vous que l'email est unique
    |> unique_constraint(:email)
    # Hachage du mot de passe
    |> put_pass_hash()
  end

  # Fonction pour hacher le mot de passe
  defp put_pass_hash(changeset) do
    if changeset.valid? do
      password = get_change(changeset, :password)

      if password do
        changeset
        |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
      else
        changeset
      end
    else
      changeset
    end
  end
end

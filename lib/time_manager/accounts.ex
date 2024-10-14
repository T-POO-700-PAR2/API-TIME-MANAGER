defmodule TimeManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  alias Bcrypt

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by email.
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Creates a user with a hashed password.
  """
  def create_user(attrs \\ %{}) do
    case Map.get(attrs, "password") do
      nil ->
        {:error, "Password is required"}
      password ->
        hashed_password = Bcrypt.hash_pwd_salt(password)
        attrs = Map.put(attrs, "password_hash", hashed_password)
        attrs = Map.delete(attrs, "password")

        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end

defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User
  alias TimeManagerWeb.Auth
  alias Bcrypt

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    password = Map.get(user_params, "password")

    # Vérifie si le mot de passe est vide ou manquant
    if is_nil(password) or password == "" do
      changeset = User.changeset(%User{}, user_params)
      changeset = Ecto.Changeset.add_error(changeset, :password, "Password is required")

      conn
      |> put_status(:unprocessable_entity)
      |> json(%{error: "Failed to create user", details: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)})
    else
      hashed_password = Bcrypt.hash_pwd_salt(password)
      user_params = Map.put(user_params, "password_hash", hashed_password)
      user_params = Map.delete(user_params, "password")

      case Accounts.create_user(user_params) do
        {:ok, %User{} = user} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", "/api/users/#{user.id}")
          |> render("show.json", user: user)

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "Failed to create user", details: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)})
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, %User{} = user} ->
        render(conn, :show, user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Failed to update user", details: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    case Accounts.delete_user(user) do
      {:ok, %User{}} ->
        send_resp(conn, :no_content, "")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Failed to delete user", details: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email(email) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})

      %User{} = user ->
        if Bcrypt.check_pass(user, password) do
          jwt = Auth.generate_jwt(user)
          conn
          |> put_resp_header("authorization", "Bearer #{jwt}")
          |> json(%{message: "Logged in successfully", token: jwt})
        else
          conn
          |> put_status(:unauthorized)
          |> json(%{error: "Invalid credentials"})
        end
    end
  end

  defp translate_error({msg, _opts}) do
    msg
  end
end

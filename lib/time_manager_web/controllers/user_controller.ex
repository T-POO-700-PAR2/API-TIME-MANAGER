defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_user_by_email(conn, %{"email" => email}) do
    case Accounts.get_user_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      user ->
        conn
        |> put_status(:ok)
        |> json(user)
    end
  end
end

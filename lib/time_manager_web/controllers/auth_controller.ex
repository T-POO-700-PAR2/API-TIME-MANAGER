defmodule TimeManagerWeb.AuthController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts
  alias TimeManagerWeb.Auth

  def signup(conn, %{"username" => username, "password" => password}) do
    case Accounts.create_user(%{username: username, password: password}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        # Ajout de put_view
        |> put_view(TimeManagerWeb.ChangesetView)
        |> render("error.json", changeset: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        # Ajout de put_view
        |> put_view(TimeManagerWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    user = Accounts.get_user_by_username(username)

    case Bcrypt.check_pass(user, password) do
      {:ok, _user} ->
        token = Auth.token()

        conn
        |> put_status(:ok)
        |> json(%{token: token})

      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{message: "Invalid credentials"})
    end
  end
end

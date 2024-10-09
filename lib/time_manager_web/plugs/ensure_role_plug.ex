defmodule TimeManagerWeb.Plugs.EnsureRolePlug do
  import Plug.Conn
  import Phoenix.Controller # Ajoute cette ligne pour utiliser la fonction json/2

  def ensure_manager_role(conn, _opts) do
    if conn.assigns[:current_user] && conn.assigns[:current_user].role == "manager" do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "Access denied: Manager role required"})
      |> halt()
    end
  end

  def ensure_general_manager_role(conn, _opts) do
    if conn.assigns[:current_user] && conn.assigns[:current_user].role == "general_manager" do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "Access denied: General Manager role required"})
      |> halt()
    end
  end
end

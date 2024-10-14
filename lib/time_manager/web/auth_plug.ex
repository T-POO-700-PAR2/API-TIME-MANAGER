defmodule TimeManagerWeb.Plugs.AuthPlug do
  import Plug.Conn
  alias TimeManagerWeb.Auth

  def init(default), do: default

  def call(conn, _default) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Auth.verify_jwt(token) do
          {:ok, claims} ->
            assign(conn, :claims, claims)

          :error ->
            conn
            |> put_status(:unauthorized)
            |> Phoenix.Controller.json(%{error: "Invalid token"})
            |> halt()
        end

      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.json(%{error: "Authorization header not found"})
        |> halt()
    end
  end
end

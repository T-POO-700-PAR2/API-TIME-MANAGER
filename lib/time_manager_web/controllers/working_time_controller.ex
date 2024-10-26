defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeTracking
  alias TimeManager.TimeTracking.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    working_times = TimeTracking.list_working_times()
    render(conn, :index, working_times: working_times)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    # S'assurer qu'un utilisateur est associé
    with {:ok, %WorkingTime{} = working_time} <-
           TimeTracking.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/working_times/#{working_time.id}")
      |> render(:show, working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = TimeTracking.get_working_time!(id)
    render(conn, :show, working_time: working_time)
  end

  def show_by_user_id(conn, %{"user_id" => user_id}) do
    working_times = TimeTracking.get_working_times_by_user_id(user_id)

    if working_times == [] do
      conn
      |> put_status(:not_found)
      |> render(TimeManagerWeb.ErrorJSON, "404.json",
        message: "Working times not found for user_id #{user_id}"
      )
    else
      # Utilise :index avec working_times:
      render(conn, :index, working_times: working_times)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeTracking.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           TimeTracking.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = TimeTracking.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- TimeTracking.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end

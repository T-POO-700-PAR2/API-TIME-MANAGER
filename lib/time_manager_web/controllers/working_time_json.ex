defmodule TimeManagerWeb.WorkingTimeJSON do
  alias TimeManager.TimeTracking.WorkingTime

  @doc """
  Renders a list of working_times.
  """
  def index(%{working_times: working_times}) do
    %{data: for(working_time <- working_times, do: data(working_time))}
  end

  @doc """
  Renders a single working_time.
  """
  # Changé de data: à working_time:
  def show(%{working_time: working_time}) do
    %{data: data(working_time)}
  end

  # Fonction de formatage pour les éléments individuels
  defp data(%WorkingTime{} = working_time) do
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      user_id: working_time.user_id
    }
  end
end

defmodule TimeManager.WebFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Web` context.
  """

  @doc """
  Generate a auth_plug.
  """
  def auth_plug_fixture(attrs \\ %{}) do
    {:ok, auth_plug} =
      attrs
      |> Enum.into(%{
        auth_plug: "some auth_plug"
      })
      |> TimeManager.Web.create_auth_plug()

    auth_plug
  end
end

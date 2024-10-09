defmodule TimeManager.GeneralManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.GeneralManager` context.
  """

  @doc """
  Generate a promotion.
  """
  def promotion_fixture(attrs \\ %{}) do
    {:ok, promotion} =
      attrs
      |> Enum.into(%{
        promote: true
      })
      |> TimeManager.GeneralManager.create_promotion()

    promotion
  end
end

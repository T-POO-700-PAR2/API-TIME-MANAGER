defmodule TimeManager.GeneralManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.GeneralManagement` context.
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
      |> TimeManager.GeneralManagement.create_promotion()

    promotion
  end
end

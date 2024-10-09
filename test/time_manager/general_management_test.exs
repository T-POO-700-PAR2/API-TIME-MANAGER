defmodule TimeManager.GeneralManagementTest do
  use TimeManager.DataCase

  alias TimeManager.GeneralManagement

  describe "promotions" do
    alias TimeManager.GeneralManagement.Promotion

    import TimeManager.GeneralManagementFixtures

    @invalid_attrs %{promote: nil}

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert GeneralManagement.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert GeneralManagement.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      valid_attrs = %{promote: true}

      assert {:ok, %Promotion{} = promotion} = GeneralManagement.create_promotion(valid_attrs)
      assert promotion.promote == true
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GeneralManagement.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      update_attrs = %{promote: false}

      assert {:ok, %Promotion{} = promotion} = GeneralManagement.update_promotion(promotion, update_attrs)
      assert promotion.promote == false
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = GeneralManagement.update_promotion(promotion, @invalid_attrs)
      assert promotion == GeneralManagement.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = GeneralManagement.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> GeneralManagement.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = GeneralManagement.change_promotion(promotion)
    end
  end
end

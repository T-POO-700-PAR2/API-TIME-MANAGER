defmodule TimeManager.WebTest do
  use TimeManager.DataCase

  alias TimeManager.Web

  describe "plugs" do
    alias TimeManager.Web.AuthPlug

    import TimeManager.WebFixtures

    @invalid_attrs %{auth_plug: nil}

    test "list_plugs/0 returns all plugs" do
      auth_plug = auth_plug_fixture()
      assert Web.list_plugs() == [auth_plug]
    end

    test "get_auth_plug!/1 returns the auth_plug with given id" do
      auth_plug = auth_plug_fixture()
      assert Web.get_auth_plug!(auth_plug.id) == auth_plug
    end

    test "create_auth_plug/1 with valid data creates a auth_plug" do
      valid_attrs = %{auth_plug: "some auth_plug"}

      assert {:ok, %AuthPlug{} = auth_plug} = Web.create_auth_plug(valid_attrs)
      assert auth_plug.auth_plug == "some auth_plug"
    end

    test "create_auth_plug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_auth_plug(@invalid_attrs)
    end

    test "update_auth_plug/2 with valid data updates the auth_plug" do
      auth_plug = auth_plug_fixture()
      update_attrs = %{auth_plug: "some updated auth_plug"}

      assert {:ok, %AuthPlug{} = auth_plug} = Web.update_auth_plug(auth_plug, update_attrs)
      assert auth_plug.auth_plug == "some updated auth_plug"
    end

    test "update_auth_plug/2 with invalid data returns error changeset" do
      auth_plug = auth_plug_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_auth_plug(auth_plug, @invalid_attrs)
      assert auth_plug == Web.get_auth_plug!(auth_plug.id)
    end

    test "delete_auth_plug/1 deletes the auth_plug" do
      auth_plug = auth_plug_fixture()
      assert {:ok, %AuthPlug{}} = Web.delete_auth_plug(auth_plug)
      assert_raise Ecto.NoResultsError, fn -> Web.get_auth_plug!(auth_plug.id) end
    end

    test "change_auth_plug/1 returns a auth_plug changeset" do
      auth_plug = auth_plug_fixture()
      assert %Ecto.Changeset{} = Web.change_auth_plug(auth_plug)
    end
  end
end

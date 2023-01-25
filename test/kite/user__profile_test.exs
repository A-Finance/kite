defmodule Kite.User_ProfileTest do
  use Kite.DataCase

  alias Kite.User_Profile

  describe "users" do
    alias Kite.User_Profile.User

    import Kite.User_ProfileFixtures

    @invalid_attrs %{access_token: nil, avatar_url: nil, broker: nil, email: nil, enctoken: nil, login_time: nil, public_token: nil, refresh_token: nil, user_id: nil, user_name: nil, user_shortname: nil, user_type: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert User_Profile.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert User_Profile.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{access_token: "some access_token", avatar_url: "some avatar_url", broker: "some broker", email: "some email", enctoken: "some enctoken", login_time: "some login_time", public_token: "some public_token", refresh_token: "some refresh_token", user_id: "some user_id", user_name: "some user_name", user_shortname: "some user_shortname", user_type: "some user_type"}

      assert {:ok, %User{} = user} = User_Profile.create_user(valid_attrs)
      assert user.access_token == "some access_token"
      assert user.avatar_url == "some avatar_url"
      assert user.broker == "some broker"
      assert user.email == "some email"
      assert user.enctoken == "some enctoken"
      assert user.login_time == "some login_time"
      assert user.public_token == "some public_token"
      assert user.refresh_token == "some refresh_token"
      assert user.user_id == "some user_id"
      assert user.user_name == "some user_name"
      assert user.user_shortname == "some user_shortname"
      assert user.user_type == "some user_type"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User_Profile.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{access_token: "some updated access_token", avatar_url: "some updated avatar_url", broker: "some updated broker", email: "some updated email", enctoken: "some updated enctoken", login_time: "some updated login_time", public_token: "some updated public_token", refresh_token: "some updated refresh_token", user_id: "some updated user_id", user_name: "some updated user_name", user_shortname: "some updated user_shortname", user_type: "some updated user_type"}

      assert {:ok, %User{} = user} = User_Profile.update_user(user, update_attrs)
      assert user.access_token == "some updated access_token"
      assert user.avatar_url == "some updated avatar_url"
      assert user.broker == "some updated broker"
      assert user.email == "some updated email"
      assert user.enctoken == "some updated enctoken"
      assert user.login_time == "some updated login_time"
      assert user.public_token == "some updated public_token"
      assert user.refresh_token == "some updated refresh_token"
      assert user.user_id == "some updated user_id"
      assert user.user_name == "some updated user_name"
      assert user.user_shortname == "some updated user_shortname"
      assert user.user_type == "some updated user_type"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = User_Profile.update_user(user, @invalid_attrs)
      assert user == User_Profile.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = User_Profile.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> User_Profile.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = User_Profile.change_user(user)
    end
  end
end

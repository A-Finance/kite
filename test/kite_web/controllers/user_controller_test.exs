defmodule KiteWeb.UserControllerTest do
  use KiteWeb.ConnCase

  import Kite.User_ProfileFixtures

  @create_attrs %{access_token: "some access_token", avatar_url: "some avatar_url", broker: "some broker", email: "some email", enctoken: "some enctoken", login_time: "some login_time", public_token: "some public_token", refresh_token: "some refresh_token", user_id: "some user_id", user_name: "some user_name", user_shortname: "some user_shortname", user_type: "some user_type"}
  @update_attrs %{access_token: "some updated access_token", avatar_url: "some updated avatar_url", broker: "some updated broker", email: "some updated email", enctoken: "some updated enctoken", login_time: "some updated login_time", public_token: "some updated public_token", refresh_token: "some updated refresh_token", user_id: "some updated user_id", user_name: "some updated user_name", user_shortname: "some updated user_shortname", user_type: "some updated user_type"}
  @invalid_attrs %{access_token: nil, avatar_url: nil, broker: nil, email: nil, enctoken: nil, login_time: nil, public_token: nil, refresh_token: nil, user_id: nil, user_name: nil, user_shortname: nil, user_type: nil}

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/users")
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/users/new")
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/users", user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/users/#{id}"

      conn = get(conn, ~p"/users/#{id}")
      assert html_response(conn, 200) =~ "User #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/users", user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get(conn, ~p"/users/#{user}/edit")
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/users/#{user}", user: @update_attrs)
      assert redirected_to(conn) == ~p"/users/#{user}"

      conn = get(conn, ~p"/users/#{user}")
      assert html_response(conn, 200) =~ "some updated access_token"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/users/#{user}", user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/users/#{user}")
      assert redirected_to(conn) == ~p"/users"

      assert_error_sent 404, fn ->
        get(conn, ~p"/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end

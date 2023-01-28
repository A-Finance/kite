defmodule KiteWeb.UserController do
  use KiteWeb, :controller

  alias Kite.User_Profile
  alias Kite.User_Profile.User
  alias KiteWeb.Request

  # constants
  @login_url "https://kite.zerodha.com/connect/login"
  @api_version "3"
  @default_headers [{"X-Kite-version", @api_version}]
  @form_encoded_headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  @request_options [
    timeout: 5_000,
    recv_timeout: 5_000
  ]

  @create_session_path "/session/token"
  @funds_and_margins_path "/user/margins"

  # def index(conn, _params) do
  #   users = User_Profile.list_users()
  #   render(conn, :index, users: users)
  # end

  def show(conn, %{"id" => id}) do
    user = User_Profile.get_user!(id)
    render(conn, :show, user: user)
  end

  # User hits login page, GET req -> redirected to zerodha login page, 302 req-> Login with zerodha credentials, GET req -> Redirect user with request token, 302 req
  def login(conn, _params) do
    conn
    |> redirect(
      external:
        @login_url <>
          "?v=" <> @api_version <> "&api_key=" <> Application.fetch_env!(:kite, :api_key)
    )
  end

  # Take the request token from login API, GET req-> Generate checksum -> Send checksum, api_key, request_token - POST req -> Receive user Json with access_token, POST res
  def create_session(conn, %{"request_token" => request_token}) when is_binary(request_token) do
    params = %{
      api_key: Application.fetch_env!(:kite, :api_key),
      request_token: request_token,
      checksum: generate_checksum(request_token)
    }

    Request.post(@create_session_path, params, [], @request_options)
    |> case do
      {:ok, user} ->
        # json(conn, %{user: user_data})
        # IO.puts(user)
        render(conn, :show, user: user)

      {:error, error} ->
        {:error, error}
    end
  end

  defp generate_checksum(request_token) do
    :crypto.hash(
      :sha256,
      Application.fetch_env!(:kite, :api_key) <>
        request_token <> Application.fetch_env!(:kite, :api_secret)
    )
    |> Base.encode16(case: :lower)
  end

  # defp auth_header(access_token) do
  #   [{"Authorization", "token " <> KiteConnectEx.api_key() <> ":" <> access_token}]
  # end
end

# def new(conn, _params) do
#   changeset = User_Profile.change_user(%User{})
#   render(conn, :new, changeset: changeset)
# end

# def create(conn, %{"user" => user_params}) do
#   case User_Profile.create_user(user_params) do
#     {:ok, user} ->
#       conn
#       |> put_flash(:info, "User created successfully.")
#       |> redirect(to: ~p"/users/#{user}")

#     {:error, %Ecto.Changeset{} = changeset} ->
#       render(conn, :new, changeset: changeset)
#   end
# end

# def edit(conn, %{"id" => id}) do
#   user = User_Profile.get_user!(id)
#   changeset = User_Profile.change_user(user)
#   render(conn, :edit, user: user, changeset: changeset)
# end

# def update(conn, %{"id" => id, "user" => user_params}) do
#   user = User_Profile.get_user!(id)

#   case User_Profile.update_user(user, user_params) do
#     {:ok, user} ->
#       conn
#       |> put_flash(:info, "User updated successfully.")
#       |> redirect(to: ~p"/users/#{user}")

#     {:error, %Ecto.Changeset{} = changeset} ->
#       render(conn, :edit, user: user, changeset: changeset)
#   end
# end

# def delete(conn, %{"id" => id}) do
#   user = User_Profile.get_user!(id)
#   {:ok, _user} = User_Profile.delete_user(user)

#   conn
#   |> put_flash(:info, "User deleted successfully.")
#   |> redirect(to: ~p"/users")
# end

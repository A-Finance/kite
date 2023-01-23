defmodule KiteWeb.UserController do
  use KiteWeb, :controller

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

  @keys [
    access_token: nil,
    api_key: nil,
    avatar_url: nil,
    broker: nil,
    email: nil,
    exchanges: nil,
    login_time: nil,
    meta: nil,
    order_types: nil,
    products: nil,
    public_token: nil,
    refresh_token: nil,
    silo: nil,
    user_id: nil,
    user_name: nil,
    user_shortname: nil,
    user_type: nil
  ]

  @type t :: %__MODULE__{
          access_token: String.t(),
          api_key: String.t(),
          avatar_url: String.t(),
          broker: String.t(),
          email: String.t(),
          exchanges: List.t(),
          login_time: String.t(),
          meta: map(),
          order_types: List.t(),
          products: List.t(),
          public_token: String.t(),
          refresh_token: String.t(),
          silo: String.t(),
          user_id: String.t(),
          user_name: String.t(),
          user_shortname: String.t(),
          user_type: String.t()
        }

  defstruct [:original_json | @keys]

  def login(conn, _params) do
    conn
    |> redirect(
      external:
        @login_url <>
          "?v=" <> @api_version <> "&api_key=" <> Application.fetch_env!(:kite, :api_key)
    )
  end

  # action=login&type=login&status=success&request_token=jSenCgNxkUn5s7rS4LbpHeE2FJr8Baw8
  def create_session(conn, %{"request_token" => request_token}) when is_binary(request_token) do
    params = %{
      api_key: Application.fetch_env!(:kite, :api_key),
      request_token: request_token,
      checksum: generate_checksum(request_token)
    }

    Request.post(@create_session_path, params, [], @request_options)
    |> case do
      {:ok, user_data} ->
        user = %__MODULE__{new(user_data) | original_json: user_data}
        json(conn, %{user: user})

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

  defp new(attributes) when is_map(attributes) do
    struct(__MODULE__, %{
      access_token: attributes["access_token"],
      api_key: attributes["api_key"],
      avatar_url: attributes["avatar_url"],
      broker: attributes["broker"],
      email: attributes["email"],
      exchanges: attributes["exchanges"],
      login_time: attributes["login_time"],
      meta: attributes["meta"],
      order_types: attributes["order_types"],
      products: attributes["products"],
      public_token: attributes["public_token"],
      refresh_token: attributes["refresh_token"],
      silo: attributes["silo"],
      user_id: attributes["user_id"],
      user_name: attributes["user_name"],
      user_shortname: attributes["user_shortname"],
      user_type: attributes["user_type"]
    })
  end

  defp new(_) do
    struct(__MODULE__, %{})
  end

  defp auth_header(access_token) do
    [{"Authorization", "token " <> KiteConnectEx.api_key() <> ":" <> access_token}]
  end
end

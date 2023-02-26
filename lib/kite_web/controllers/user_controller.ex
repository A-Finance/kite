defmodule KiteWeb.UserController do
  use KiteWeb, :controller

  alias Kite.User_Profile
  alias Kite.User_Profile.User
  alias KiteWeb.Request
  alias KiteWeb.Auth

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

  # Listing all users, for testing purpose, wont be released to prod.
  def index(conn, _params) do
    users = User_Profile.list_users()
    render(conn, :index, users: users)
  end

  # def show(conn, %{"id" => id}) do
  #   user = User_Profile.get_user(id)
  #   render(conn, :show, user: user)
  # end

  # User hits login page, GET req -> redirected to zerodha login page, 302 req-> Login with zerodha credentials, GET req -> Redirect user with request token, 302 req
  def login(conn, _params) do
    conn =
      conn
      |> configure_session(renew: true)
      |> clear_session()

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
        saved_user = save_user(conn, user)

        conn =
          conn
          |> put_session(:user_id, saved_user.user_id)

        # get_session(conn, :user_id) |> IO.inspect()
        # fetch_cookies(conn, ~w(user-id-cookie)) |> IO.inspect()
        render(conn, :show, user: saved_user)

      {:error, error} ->
        {:error, error}
    end
  end

  # Get user's funds and margins of segments: "equity" || "commodity"
  # default segment_type: equity

  ## Example

  # {:ok, funds_and_margins} = KiteConnectEx.User.funds_and_margins("access-token")

  # {:ok, funds_and_margins} = KiteConnectEx.User.funds_and_margins("access-token", "commodity")

  def funds_and_margins(conn, %{"segment_type" => segment_type}) do
    # "segment_type" |> IO.inspect()
    # segment_type |> IO.inspect()
    url = @funds_and_margins_path <> "/" <> segment_type
    user_id = get_session(conn, :user_id)
    {:ok, access_token} = Auth.get_access_token(user_id)

    Request.get(url, nil, auth_header(access_token), @request_options)
    |> case do
      {:ok, data} ->
        # Inside data user_id not present but its present in db, Might cause error.
        funds_and_margins = save_funds_and_margins_data(user_id, data, segment_type)
        # "funds_and_margins" |> IO.inspect()
        # funds_and_margins |> IO.inspect()

        case segment_type do
          "equity" ->
            render(conn, :funds_margins_equity, data: funds_and_margins)

          "commodity" ->
            render(conn, :funds_margins_commodity, data: funds_and_margins)
        end

      # {:ok, funds_and_margins}

      {:error, error} ->
        {:error, error}
    end
  end

  # net: attributes["net"],
  # available: AvailableSegment.new(attributes["available"]),
  # utilised: UtilisedSegment.new(attributes["utilised"]),
  # debits: Float.t(),
  # exposure: Float.t(),
  # m2m_realised: Float.t(),
  # m2m_unrealised: Float.t(),
  # option_premium: Float.t(),
  # payout: Float.t(),
  # span: Float.t(),
  # holding_sales: Float.t(),
  # turnover: Float.t(),
  # "liquid_collateral": 0,
  # "stock_collateral": 0,
  # "delivery": 0

  # enabled:boolean net:float adhoc_margin:float cash:float opening_balance:float live_balance:float collateral:float intraday_payin:float debits:float exposure:float m2m_realised:float m2m_unrealised:float option_premium:float payout:float span:float holding_sales:float turnover:float liquid_collateral:float stock_collateral:float delivery:float
  # "enabled": true,
  # "net": 99725.05000000002,
  # "available": {
  #   "adhoc_margin": ,
  #   "cash": 245431.6,
  #   "opening_balance": 245431.6,
  #   "live_balance": 99725.05000000002,
  #   "collateral": 0,
  #   "intraday_payin": 0
  # },
  # "utilised": {
  #   "debits": 145706.55,
  #   "exposure": 38981.25,
  #   "m2m_realised": 761.7,
  #   "m2m_unrealised": 0,
  #   "option_premium": 0,
  #   "payout": 0,
  #   "span": 101989,
  #   "holding_sales": 0,
  #   "turnover": 0,
  #   "liquid_collateral": 0,
  #   "stock_collateral": 0,
  #   "delivery": 0
  # }

  defp save_user(conn, user) do
    case User_Profile.create_user(user) do
      {:ok, user} ->
        # conn =
        #   conn
        #   |> put_resp_cookie("user-id-cookie", user.user_id, sign: true)
        user

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset
    end
  end

  defp save_funds_and_margins_data(user_id, data, segment_type) do
    case User_Profile.create_funds_and_margins(user_id, data, segment_type) do
      {:ok, data} ->
        # "data" |> IO.inspect()
        # data |> IO.inspect()
        data

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset
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

  defp auth_header(access_token) do
    [
      {"Authorization",
       "token " <> Application.fetch_env!(:kite, :api_key) <> ":" <> access_token}
    ]
  end
end

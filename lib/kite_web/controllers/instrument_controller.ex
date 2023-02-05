# defmodule KiteWeb.Instrument do
#   use KiteWeb, :controller

#   alias Kite.User_Profile
#   alias Kite.User_Profile.User
#   alias KiteWeb.Request
#   alias KiteConnectEx.Portfolio.Holding

#   # constants
#   @api_version "3"
#   @default_headers [{"X-Kite-version", @api_version}]
#   @form_encoded_headers [{"Content-Type", "application/x-www-form-urlencoded"}]
#   @api_key Application.fetch_env!(:kite, :api_key)

#   @request_options [
#     timeout: 5_000,
#     recv_timeout: 5_000
#   ]

#   # @create_session_path "/session/token"
#   # @funds_and_margins_path "/user/margins"
#   @instruments_base_path "/instruments"
#   @doc """
#   Get all tradable `instruments` by `exchange`

#   ## Example

#     {:ok, instruments} = KiteConnectEx.Portfolio.instruments("access-token", "NSE")
#   """
#   def instruments(exchange) when is_binary(access_token) do
#     Request.get(
#       instruments_path(exchange),
#       nil,
#       auth_header(access_token),
#       @request_options
#     )
#     |> case do
#       {:ok, instruments_csv_dump} ->
#         {:ok, instruments_csv_dump}

#       {:error, error} ->
#         {:error, error}
#     end
#   end

#   defp instruments_path(exchange) do
#     @instruments_base_path <> "/" <> exchange
#   end

#   defp auth_header(access_token) do
#     [{"Authorization", "token " <> @api_key() <> ":" <> access_token}]
#   end
# end

defmodule KiteWeb.InstrumentController do
  use KiteWeb, :controller

  alias Kite.User_Profile
  alias Kite.User_Profile.User
  alias KiteWeb.Request
  alias KiteWeb.Auth
  alias NimbleCSV.RFC4180, as: CSV

  # constants
  @api_version "3"
  @default_headers [{"X-Kite-version", @api_version}]
  @form_encoded_headers [{"Content-Type", "application/x-www-form-urlencoded"}]
  @api_key Application.fetch_env!(:kite, :api_key)

  @request_options [
    timeout: 5_000,
    recv_timeout: 5_000
  ]

  # @create_session_path "/session/token"
  # @funds_and_margins_path "/user/margins"
  @instruments_base_path "/instruments"
  @doc """
  Get all tradable `instruments` by `exchange`
  
  ## Example
  
    {:ok, instruments} = KiteConnectEx.Portfolio.instruments("access-token", "NSE")
  """
  def instruments(conn, %{"exchange" => exchange}) do
    user_id = get_session(conn, :user_id)

    access_token =
      Auth.get_access_token(user_id)
      |> case do
        {:ok, access_token} ->
          access_token

        {:error, error} ->
          {:error, json(conn, error)}
      end

    Request.get(instruments_path(exchange), nil, auth_header(access_token), @request_options)
    |> case do
      {:ok, instruments_csv_dump} ->
        {:ok, instruments_csv_dump}

        res = store_and_extract_csv_data(instruments_csv_dump)
        # Probably upload this dump to a file and then stream it from the file
        json(conn, res)

      {:error, error} ->
        {:error, json(conn, error)}
    end

    # {:error, error} ->
    #   {:error, json(conn, error)}
    # end
  end

  defp instruments_path(exchange) do
    @instruments_base_path <> "/" <> exchange
  end

  defp auth_header(access_token) do
    [{"Authorization", "token " <> @api_key <> ":" <> access_token}]
  end

  def store_and_extract_csv_data(data) do
    # Define the path and filename for the file you want to write.
    path = "/csv"
    current_dir = __DIR__
    filename = "file.csv"

    # Concatenate the path and filename.
    file_path = Path.join([current_dir, path, filename])

    # Write the contents to the file.
    File.write!(file_path, data)

    # Read the contents back from the file.
    {:ok, file_data} = File.read(file_path)

    column_names = get_column_names(file_path)

    "column_names" |> IO.inspect()
    column_names |> IO.inspect()

    res =
      file_path
      |> File.stream!()
      |> CSV.parse_stream(skip_headers: true)
      |> Enum.map(fn row ->
        row
        |> Enum.with_index()
        |> Map.new(fn {val, num} -> {column_names[num], val} end)
        |> create_or_skip()
      end)

    # "file data" |> IO.inspect()
    # res |> IO.inspect()

    column_names
  end

  def get_column_names(file) do
    # res =
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)

    # "column names" |> IO.inspect()
    # res |> IO.inspect()
  end

  def create_or_skip(row) do
    # "csv row" |> IO.inspect()
    # row |> IO.inspect()
    {:ok, row}
  end
end

# case Repo.get_by(Campaign,
#        id: row["id"]
#      ) do
#   nil ->
#     Repo.insert(
#       %Campaign{}
#       |> Campaign.changeset(%{
#         id: Integer.new(row["id"]),
#         name: row["name"],
#         start_date: row["start_date"],
#         end_date: row["end_date"],
#         budget: Integer.new(row["budget"]),
#         hashtags: row["hashtags"],
#         team_id: Integer.new(row["team_id"]),
#         description: row["description"]
#       })
#     )

#   campaign ->
#     {:ok, campaign}
# end
# end

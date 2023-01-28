defmodule KiteWeb.Response do
  @type success :: {:ok, map}
  @type error :: {:error, %KiteWeb.Error{}}

  @success_status_codes [200, 201]

  @success_status "success"
  @error_status "error"

  @csv_content_type {"Content-Type", "text/csv"}

  def parse_response(%HTTPoison.Response{} = response) do
    case response do
      %{body: body, headers: headers, status_code: status} when status in @success_status_codes ->
        {:ok, do_parse_response(headers, body)}

      %{body: body, headers: headers, status_code: _status} ->
        {:error, do_parse_response(headers, body)}
    end
  end

  defp do_parse_response(headers, body) do
    has_csv_header?(headers)
    |> case do
      true ->
        body

      _ ->
        body
        |> Jason.decode!()
        |> parse_body()
    end
  end

  defp has_csv_header?([]), do: false

  defp has_csv_header?([header | _tail]) when header == @csv_content_type do
    true
  end

  defp has_csv_header?([_header | tail]) do
    has_csv_header?(tail)
  end

  def parse_error(%HTTPoison.Error{} = error) do
    error =
      %{"message" => "invalid response - " <> inspect(error)}
      |> KiteWeb.Error.new()

    {:error, error}
  end

  defp parse_body(%{"status" => @success_status, "data" => data} = _body) do
    data
  end

  defp parse_body(
         %{"status" => @error_status, "message" => message, "error_type" => error_type} = _body
       ) do
    %{"error_type" => error_type, "message" => message}
    |> KiteWeb.Error.new()
  end

  defp parse_body(body) do
    KiteWeb.Error.new(body)
  end
end

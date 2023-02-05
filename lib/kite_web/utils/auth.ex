defmodule KiteWeb.Auth do
  alias Kite.User_Profile
  alias Kite.User_Profile.User

  def get_access_token(user_id \\ nil) do
    # "User ID" |> IO.inspect()
    # user_id |> IO.inspect()
    {:ok, access_token} = User_Profile.get_access_token_for_zerodha(user_id)
    access_token
  end
end

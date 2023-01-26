defmodule KiteWeb.PageController do
  use KiteWeb, :controller

  alias Kite.User_Profile
  alias Kite.User_Profile.User

  def login(conn, _params) do
    # The login/static page is often custom made,
    # so skip the default app layout.
    render(conn, :login, layout: false)
  end
end

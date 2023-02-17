# Kite

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

### Whem making changes to schema
mix ecto.rollback
mix ecto.migrate


## Flow:

  ### User funds and margins feature:
    - Get the segment type from url.
    - Get the user_id from session.
    - Using user_id, get access token.
    - Use this access token, segment type and get funds and margin data from zerodha kite connect API.
    - Pass data, user id, segment type to a helper function to interact with persistance layer.
    - In persistent layer, first check for segment type and redirect to appropriate functions.
    - In the function, first check if entry is already made in db with help of user id.
    - Extract the values and restructure data to make it feasible.
    - If entry is made, just update the values.
    - If entry is not made, insert the values into db.
    - Return data to controller.
    - Depending on segment, render appropriate html files.
      
    - What i learnt:
      - Anticipated potential buggy codes.
      - Thought process to come up with this flow by myself.
      - Restructing data, function pattern matching, case coditioning, helper functions.
      - Session  handling, plug and conn.
      - Ecto data accesing, elixir struct accesing



Redirect to a page code: 
  <!-- def home_page(conn, params \\ %{}) do
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  def index(conn, params) do
    render(conn, "home_page.html",
      conn: conn,
      page_title: "DhanLAP - Get Instant loan against mutual funds"
    )
  end -->

{
  "0": "instrument_token",
  "1": "exchange_token",
  "2": "tradingsymbol",
  "3": "name",
  "4": "last_price",
  "5": "expiry",
  "6": "strike",
  "7": "tick_size",
  "8": "lot_size",
  "9": "instrument_type",
  "10": "segment",
  "11": "exchange"
}
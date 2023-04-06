defmodule Kite.Instruments.MarketInstruments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "market_instruments" do
    field(:exchange, :string)
    field(:exchange_token, :string)
    field(:expiry, :string)
    field(:instrument_token, :string)
    field(:instrument_type, :string)
    field(:last_price, :string)
    field(:lot_size, :string)
    field(:market_watch_id, :string)
    field(:name, :string)
    field(:segment, :string)
    field(:strike, :string)
    field(:tick_size, :string)
    field(:tradingsymbol, :string)

    timestamps()
  end

  @doc false
  def changeset(market_instruments, attrs) do
    market_instruments
    |> cast(attrs, [
      :exchange,
      :exchange_token,
      :expiry,
      :instrument_token,
      :instrument_type,
      :last_price,
      :lot_size,
      :name,
      :segment,
      :strike,
      :tick_size,
      :tradingsymbol,
      :market_watch_id
    ])
    |> validate_required([
      :exchange,
      :exchange_token,
      :expiry,
      :instrument_token,
      :instrument_type,
      :last_price,
      :lot_size,
      :name,
      :segment,
      :strike,
      :tick_size,
      :tradingsymbol,
      :market_watch_id
    ])
    |> unique_constraint(:market_watch_id)
  end
end

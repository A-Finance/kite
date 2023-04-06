defmodule Kite.Instruments.NSE do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nse" do
    field(:exchange, :string)
    field(:exchange_token, :string)
    field(:expiry, :string, default: "nil")
    field(:instrument_token, :string)
    field(:instrument_type, :string)
    field(:last_price, :string)
    field(:lot_size, :string)
    field(:name, :string)
    field(:segment, :string)
    field(:strike, :string)
    field(:tick_size, :string)
    field(:tradingsymbol, :string)

    timestamps()
  end

  @doc false
  def changeset(nse, attrs) do
    nse
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
      :tradingsymbol
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
      :tradingsymbol
    ])
    |> unique_constraint(:exchange_token)
  end
end

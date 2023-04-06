defmodule Kite.InstrumentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kite.Instruments` context.
  """

  @doc """
  Generate a nse.
  """
  def nse_fixture(attrs \\ %{}) do
    {:ok, nse} =
      attrs
      |> Enum.into(%{
        exchange: "some exchange",
        exchange_token: "some exchange_token",
        expiry: "some expiry",
        instrument_token: "some instrument_token",
        instrument_type: "some instrument_type",
        last_price: "some last_price",
        lot_size: "some lot_size",
        name: "some name",
        segment: "some segment",
        strike: "some strike",
        tick_size: "some tick_size",
        tradingsymbol: "some tradingsymbol"
      })
      |> Kite.Instruments.create_nse()

    nse
  end
end

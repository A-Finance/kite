defmodule Kite.Instruments do
  import Ecto.Query, warn: false
  alias Kite.Repo

  alias Kite.Instruments.NSE
  alias Kite.Instruments.MarketInstruments

  def list_instruments do
    Repo.all(MarketInstruments)
  end

  def get_instrument(market_watch_id) do
    Repo.get_by(MarketInstruments, market_watch_id: market_watch_id)
  end

  def create_instrument(attrs \\ %{}) do
    # "attributres" |> IO.inspect()
    # attrs |> IO.inspect()
    instrument = get_instrument(attrs["market_watch_id"])

    if instrument != nil do
      updated_instrument = update_instrument(instrument, attrs)
      {:ok, updated_instrument}
    else
      res =
        %MarketInstruments{}
        |> MarketInstruments.changeset(attrs)
        |> Repo.insert()

      res
    end
  end

  def update_instrument(%MarketInstruments{} = instrument, attrs) do
    instrument
    |> MarketInstruments.changeset(attrs)
    |> Repo.update()
  end

  # ⭐ NSE alone

  def list_nse do
    Repo.all(NSE)
  end

  def get_nse!(id), do: Repo.get!(NSE, id)

  def get_nse_instrument(exchange_token) do
    Repo.get_by(NSE, exchange_token: exchange_token)
  end

  def create_nse_instruments(attrs \\ %{}) do
    # "attributres" |> IO.inspect()
    # attrs |> IO.inspect()
    instrument = get_nse_instrument(attrs["exchange_token"])

    if instrument != nil do
      updated_instrument = update_nse_instrument(instrument, attrs)
      {:ok, updated_instrument}
    else
      res =
        %NSE{}
        |> NSE.changeset(attrs)
        |> Repo.insert()

      res
    end
  end

  def update_nse_instrument(%NSE{} = nse, attrs) do
    nse
    |> NSE.changeset(attrs)
    |> Repo.update()
  end

  def delete_nse(%NSE{} = nse) do
    Repo.delete(nse)
  end

  def change_nse(%NSE{} = nse, attrs \\ %{}) do
    NSE.changeset(nse, attrs)
  end
end

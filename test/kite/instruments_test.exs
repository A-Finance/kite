defmodule Kite.InstrumentsTest do
  use Kite.DataCase

  alias Kite.Instruments

  describe "nse" do
    alias Kite.Instruments.NSE

    import Kite.InstrumentsFixtures

    @invalid_attrs %{exchange: nil, exchange_token: nil, expiry: nil, instrument_token: nil, instrument_type: nil, last_price: nil, lot_size: nil, name: nil, segment: nil, strike: nil, tick_size: nil, tradingsymbol: nil}

    test "list_nse/0 returns all nse" do
      nse = nse_fixture()
      assert Instruments.list_nse() == [nse]
    end

    test "get_nse!/1 returns the nse with given id" do
      nse = nse_fixture()
      assert Instruments.get_nse!(nse.id) == nse
    end

    test "create_nse/1 with valid data creates a nse" do
      valid_attrs = %{exchange: "some exchange", exchange_token: "some exchange_token", expiry: "some expiry", instrument_token: "some instrument_token", instrument_type: "some instrument_type", last_price: "some last_price", lot_size: "some lot_size", name: "some name", segment: "some segment", strike: "some strike", tick_size: "some tick_size", tradingsymbol: "some tradingsymbol"}

      assert {:ok, %NSE{} = nse} = Instruments.create_nse(valid_attrs)
      assert nse.exchange == "some exchange"
      assert nse.exchange_token == "some exchange_token"
      assert nse.expiry == "some expiry"
      assert nse.instrument_token == "some instrument_token"
      assert nse.instrument_type == "some instrument_type"
      assert nse.last_price == "some last_price"
      assert nse.lot_size == "some lot_size"
      assert nse.name == "some name"
      assert nse.segment == "some segment"
      assert nse.strike == "some strike"
      assert nse.tick_size == "some tick_size"
      assert nse.tradingsymbol == "some tradingsymbol"
    end

    test "create_nse/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Instruments.create_nse(@invalid_attrs)
    end

    test "update_nse/2 with valid data updates the nse" do
      nse = nse_fixture()
      update_attrs = %{exchange: "some updated exchange", exchange_token: "some updated exchange_token", expiry: "some updated expiry", instrument_token: "some updated instrument_token", instrument_type: "some updated instrument_type", last_price: "some updated last_price", lot_size: "some updated lot_size", name: "some updated name", segment: "some updated segment", strike: "some updated strike", tick_size: "some updated tick_size", tradingsymbol: "some updated tradingsymbol"}

      assert {:ok, %NSE{} = nse} = Instruments.update_nse(nse, update_attrs)
      assert nse.exchange == "some updated exchange"
      assert nse.exchange_token == "some updated exchange_token"
      assert nse.expiry == "some updated expiry"
      assert nse.instrument_token == "some updated instrument_token"
      assert nse.instrument_type == "some updated instrument_type"
      assert nse.last_price == "some updated last_price"
      assert nse.lot_size == "some updated lot_size"
      assert nse.name == "some updated name"
      assert nse.segment == "some updated segment"
      assert nse.strike == "some updated strike"
      assert nse.tick_size == "some updated tick_size"
      assert nse.tradingsymbol == "some updated tradingsymbol"
    end

    test "update_nse/2 with invalid data returns error changeset" do
      nse = nse_fixture()
      assert {:error, %Ecto.Changeset{}} = Instruments.update_nse(nse, @invalid_attrs)
      assert nse == Instruments.get_nse!(nse.id)
    end

    test "delete_nse/1 deletes the nse" do
      nse = nse_fixture()
      assert {:ok, %NSE{}} = Instruments.delete_nse(nse)
      assert_raise Ecto.NoResultsError, fn -> Instruments.get_nse!(nse.id) end
    end

    test "change_nse/1 returns a nse changeset" do
      nse = nse_fixture()
      assert %Ecto.Changeset{} = Instruments.change_nse(nse)
    end
  end
end

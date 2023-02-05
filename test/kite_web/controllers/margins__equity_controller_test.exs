defmodule KiteWeb.Margins_EquityControllerTest do
  use KiteWeb.ConnCase

  import Kite.User__profileFixtures

  @create_attrs %{adhoc_margin: 120.5, cash: 120.5, collateral: 120.5, debits: 120.5, delivery: 120.5, enabled: true, exposure: 120.5, holding_sales: 120.5, intraday_payin: 120.5, liquid_collateral: 120.5, live_balance: 120.5, m2m_realised: 120.5, m2m_unrealised: 120.5, net: 120.5, opening_balance: 120.5, option_premium: 120.5, payout: 120.5, span: 120.5, stock_collateral: 120.5, turnover: 120.5}
  @update_attrs %{adhoc_margin: 456.7, cash: 456.7, collateral: 456.7, debits: 456.7, delivery: 456.7, enabled: false, exposure: 456.7, holding_sales: 456.7, intraday_payin: 456.7, liquid_collateral: 456.7, live_balance: 456.7, m2m_realised: 456.7, m2m_unrealised: 456.7, net: 456.7, opening_balance: 456.7, option_premium: 456.7, payout: 456.7, span: 456.7, stock_collateral: 456.7, turnover: 456.7}
  @invalid_attrs %{adhoc_margin: nil, cash: nil, collateral: nil, debits: nil, delivery: nil, enabled: nil, exposure: nil, holding_sales: nil, intraday_payin: nil, liquid_collateral: nil, live_balance: nil, m2m_realised: nil, m2m_unrealised: nil, net: nil, opening_balance: nil, option_premium: nil, payout: nil, span: nil, stock_collateral: nil, turnover: nil}

  describe "index" do
    test "lists all margins_equity", %{conn: conn} do
      conn = get(conn, ~p"/margins_equity")
      assert html_response(conn, 200) =~ "Listing Margins equity"
    end
  end

  describe "new margins__equity" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/margins_equity/new")
      assert html_response(conn, 200) =~ "New Margins  equity"
    end
  end

  describe "create margins__equity" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/margins_equity", margins__equity: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/margins_equity/#{id}"

      conn = get(conn, ~p"/margins_equity/#{id}")
      assert html_response(conn, 200) =~ "Margins  equity #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/margins_equity", margins__equity: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Margins  equity"
    end
  end

  describe "edit margins__equity" do
    setup [:create_margins__equity]

    test "renders form for editing chosen margins__equity", %{conn: conn, margins__equity: margins__equity} do
      conn = get(conn, ~p"/margins_equity/#{margins__equity}/edit")
      assert html_response(conn, 200) =~ "Edit Margins  equity"
    end
  end

  describe "update margins__equity" do
    setup [:create_margins__equity]

    test "redirects when data is valid", %{conn: conn, margins__equity: margins__equity} do
      conn = put(conn, ~p"/margins_equity/#{margins__equity}", margins__equity: @update_attrs)
      assert redirected_to(conn) == ~p"/margins_equity/#{margins__equity}"

      conn = get(conn, ~p"/margins_equity/#{margins__equity}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, margins__equity: margins__equity} do
      conn = put(conn, ~p"/margins_equity/#{margins__equity}", margins__equity: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Margins  equity"
    end
  end

  describe "delete margins__equity" do
    setup [:create_margins__equity]

    test "deletes chosen margins__equity", %{conn: conn, margins__equity: margins__equity} do
      conn = delete(conn, ~p"/margins_equity/#{margins__equity}")
      assert redirected_to(conn) == ~p"/margins_equity"

      assert_error_sent 404, fn ->
        get(conn, ~p"/margins_equity/#{margins__equity}")
      end
    end
  end

  defp create_margins__equity(_) do
    margins__equity = margins__equity_fixture()
    %{margins__equity: margins__equity}
  end
end

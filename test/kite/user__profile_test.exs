defmodule Kite.User_ProfileTest do
  use Kite.DataCase

  alias Kite.User_Profile

  describe "users" do
    alias Kite.UserProfile.User

    import Kite.User_ProfileFixtures

    @invalid_attrs %{
      access_token: nil,
      avatar_url: nil,
      broker: nil,
      email: nil,
      enctoken: nil,
      login_time: nil,
      public_token: nil,
      refresh_token: nil,
      user_id: nil,
      user_name: nil,
      user_shortname: nil,
      user_type: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert User_Profile.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert User_Profile.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        access_token: "some access_token",
        avatar_url: "some avatar_url",
        broker: "some broker",
        email: "some email",
        enctoken: "some enctoken",
        login_time: "some login_time",
        public_token: "some public_token",
        refresh_token: "some refresh_token",
        user_id: "some user_id",
        user_name: "some user_name",
        user_shortname: "some user_shortname",
        user_type: "some user_type"
      }

      assert {:ok, %User{} = user} = User_Profile.create_user(valid_attrs)
      assert user.access_token == "some access_token"
      assert user.avatar_url == "some avatar_url"
      assert user.broker == "some broker"
      assert user.email == "some email"
      assert user.enctoken == "some enctoken"
      assert user.login_time == "some login_time"
      assert user.public_token == "some public_token"
      assert user.refresh_token == "some refresh_token"
      assert user.user_id == "some user_id"
      assert user.user_name == "some user_name"
      assert user.user_shortname == "some user_shortname"
      assert user.user_type == "some user_type"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User_Profile.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        access_token: "some updated access_token",
        avatar_url: "some updated avatar_url",
        broker: "some updated broker",
        email: "some updated email",
        enctoken: "some updated enctoken",
        login_time: "some updated login_time",
        public_token: "some updated public_token",
        refresh_token: "some updated refresh_token",
        user_id: "some updated user_id",
        user_name: "some updated user_name",
        user_shortname: "some updated user_shortname",
        user_type: "some updated user_type"
      }

      assert {:ok, %User{} = user} = User_Profile.update_user(user, update_attrs)
      assert user.access_token == "some updated access_token"
      assert user.avatar_url == "some updated avatar_url"
      assert user.broker == "some updated broker"
      assert user.email == "some updated email"
      assert user.enctoken == "some updated enctoken"
      assert user.login_time == "some updated login_time"
      assert user.public_token == "some updated public_token"
      assert user.refresh_token == "some updated refresh_token"
      assert user.user_id == "some updated user_id"
      assert user.user_name == "some updated user_name"
      assert user.user_shortname == "some updated user_shortname"
      assert user.user_type == "some updated user_type"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = User_Profile.update_user(user, @invalid_attrs)
      assert user == User_Profile.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = User_Profile.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> User_Profile.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = User_Profile.change_user(user)
    end
  end

  describe "margins_equity" do
    alias Kite.UserProfile.MarginsEquity

    import Kite.User__profileFixtures

    @invalid_attrs %{
      adhoc_margin: nil,
      cash: nil,
      collateral: nil,
      debits: nil,
      delivery: nil,
      enabled: nil,
      exposure: nil,
      holding_sales: nil,
      intraday_payin: nil,
      liquid_collateral: nil,
      live_balance: nil,
      m2m_realised: nil,
      m2m_unrealised: nil,
      net: nil,
      opening_balance: nil,
      option_premium: nil,
      payout: nil,
      span: nil,
      stock_collateral: nil,
      turnover: nil
    }

    test "list_margins_equity/0 returns all margins_equity" do
      margins__equity = margins__equity_fixture()
      assert User__profile.list_margins_equity() == [margins__equity]
    end

    test "get_margins__equity!/1 returns the margins__equity with given id" do
      margins__equity = margins__equity_fixture()
      assert User__profile.get_margins__equity!(margins__equity.id) == margins__equity
    end

    test "create_margins__equity/1 with valid data creates a margins__equity" do
      valid_attrs = %{
        adhoc_margin: 120.5,
        cash: 120.5,
        collateral: 120.5,
        debits: 120.5,
        delivery: 120.5,
        enabled: true,
        exposure: 120.5,
        holding_sales: 120.5,
        intraday_payin: 120.5,
        liquid_collateral: 120.5,
        live_balance: 120.5,
        m2m_realised: 120.5,
        m2m_unrealised: 120.5,
        net: 120.5,
        opening_balance: 120.5,
        option_premium: 120.5,
        payout: 120.5,
        span: 120.5,
        stock_collateral: 120.5,
        turnover: 120.5
      }

      assert {:ok, %Margins_Equity{} = margins__equity} =
               User__profile.create_margins__equity(valid_attrs)

      assert margins__equity.adhoc_margin == 120.5
      assert margins__equity.cash == 120.5
      assert margins__equity.collateral == 120.5
      assert margins__equity.debits == 120.5
      assert margins__equity.delivery == 120.5
      assert margins__equity.enabled == true
      assert margins__equity.exposure == 120.5
      assert margins__equity.holding_sales == 120.5
      assert margins__equity.intraday_payin == 120.5
      assert margins__equity.liquid_collateral == 120.5
      assert margins__equity.live_balance == 120.5
      assert margins__equity.m2m_realised == 120.5
      assert margins__equity.m2m_unrealised == 120.5
      assert margins__equity.net == 120.5
      assert margins__equity.opening_balance == 120.5
      assert margins__equity.option_premium == 120.5
      assert margins__equity.payout == 120.5
      assert margins__equity.span == 120.5
      assert margins__equity.stock_collateral == 120.5
      assert margins__equity.turnover == 120.5
    end

    test "create_margins__equity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User__profile.create_margins__equity(@invalid_attrs)
    end

    test "update_margins__equity/2 with valid data updates the margins__equity" do
      margins__equity = margins__equity_fixture()

      update_attrs = %{
        adhoc_margin: 456.7,
        cash: 456.7,
        collateral: 456.7,
        debits: 456.7,
        delivery: 456.7,
        enabled: false,
        exposure: 456.7,
        holding_sales: 456.7,
        intraday_payin: 456.7,
        liquid_collateral: 456.7,
        live_balance: 456.7,
        m2m_realised: 456.7,
        m2m_unrealised: 456.7,
        net: 456.7,
        opening_balance: 456.7,
        option_premium: 456.7,
        payout: 456.7,
        span: 456.7,
        stock_collateral: 456.7,
        turnover: 456.7
      }

      assert {:ok, %Margins_Equity{} = margins__equity} =
               User__profile.update_margins__equity(margins__equity, update_attrs)

      assert margins__equity.adhoc_margin == 456.7
      assert margins__equity.cash == 456.7
      assert margins__equity.collateral == 456.7
      assert margins__equity.debits == 456.7
      assert margins__equity.delivery == 456.7
      assert margins__equity.enabled == false
      assert margins__equity.exposure == 456.7
      assert margins__equity.holding_sales == 456.7
      assert margins__equity.intraday_payin == 456.7
      assert margins__equity.liquid_collateral == 456.7
      assert margins__equity.live_balance == 456.7
      assert margins__equity.m2m_realised == 456.7
      assert margins__equity.m2m_unrealised == 456.7
      assert margins__equity.net == 456.7
      assert margins__equity.opening_balance == 456.7
      assert margins__equity.option_premium == 456.7
      assert margins__equity.payout == 456.7
      assert margins__equity.span == 456.7
      assert margins__equity.stock_collateral == 456.7
      assert margins__equity.turnover == 456.7
    end

    test "update_margins__equity/2 with invalid data returns error changeset" do
      margins__equity = margins__equity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               User__profile.update_margins__equity(margins__equity, @invalid_attrs)

      assert margins__equity == User__profile.get_margins__equity!(margins__equity.id)
    end

    test "delete_margins__equity/1 deletes the margins__equity" do
      margins__equity = margins__equity_fixture()
      assert {:ok, %Margins_Equity{}} = User__profile.delete_margins__equity(margins__equity)

      assert_raise Ecto.NoResultsError, fn ->
        User__profile.get_margins__equity!(margins__equity.id)
      end
    end

    test "change_margins__equity/1 returns a margins__equity changeset" do
      margins__equity = margins__equity_fixture()
      assert %Ecto.Changeset{} = User__profile.change_margins__equity(margins__equity)
    end
  end

  describe "margins_commodity" do
    alias Kite.UserProfile.MarginsCommodity

    import Kite.User__profileFixtures

    @invalid_attrs %{
      adhoc_margin: nil,
      cash: nil,
      collateral: nil,
      debits: nil,
      delivery: nil,
      enabled: nil,
      exposure: nil,
      holding_sales: nil,
      intraday_payin: nil,
      liquid_collateral: nil,
      live_balance: nil,
      m2m_realised: nil,
      m2m_unrealised: nil,
      net: nil,
      opening_balance: nil,
      option_premium: nil,
      payout: nil,
      span: nil,
      stock_collateral: nil,
      turnover: nil
    }

    test "list_margins_commodity/0 returns all margins_commodity" do
      margins__commodity = margins__commodity_fixture()
      assert User__profile.list_margins_commodity() == [margins__commodity]
    end

    test "get_margins__commodity!/1 returns the margins__commodity with given id" do
      margins__commodity = margins__commodity_fixture()
      assert User__profile.get_margins__commodity!(margins__commodity.id) == margins__commodity
    end

    test "create_margins__commodity/1 with valid data creates a margins__commodity" do
      valid_attrs = %{
        adhoc_margin: 120.5,
        cash: 120.5,
        collateral: 120.5,
        debits: 120.5,
        delivery: 120.5,
        enabled: true,
        exposure: 120.5,
        holding_sales: 120.5,
        intraday_payin: 120.5,
        liquid_collateral: 120.5,
        live_balance: 120.5,
        m2m_realised: 120.5,
        m2m_unrealised: 120.5,
        net: 120.5,
        opening_balance: 120.5,
        option_premium: 120.5,
        payout: 120.5,
        span: 120.5,
        stock_collateral: 120.5,
        turnover: 120.5
      }

      assert {:ok, %Margins_Commodity{} = margins__commodity} =
               User__profile.create_margins__commodity(valid_attrs)

      assert margins__commodity.adhoc_margin == 120.5
      assert margins__commodity.cash == 120.5
      assert margins__commodity.collateral == 120.5
      assert margins__commodity.debits == 120.5
      assert margins__commodity.delivery == 120.5
      assert margins__commodity.enabled == true
      assert margins__commodity.exposure == 120.5
      assert margins__commodity.holding_sales == 120.5
      assert margins__commodity.intraday_payin == 120.5
      assert margins__commodity.liquid_collateral == 120.5
      assert margins__commodity.live_balance == 120.5
      assert margins__commodity.m2m_realised == 120.5
      assert margins__commodity.m2m_unrealised == 120.5
      assert margins__commodity.net == 120.5
      assert margins__commodity.opening_balance == 120.5
      assert margins__commodity.option_premium == 120.5
      assert margins__commodity.payout == 120.5
      assert margins__commodity.span == 120.5
      assert margins__commodity.stock_collateral == 120.5
      assert margins__commodity.turnover == 120.5
    end

    test "create_margins__commodity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User__profile.create_margins__commodity(@invalid_attrs)
    end

    test "update_margins__commodity/2 with valid data updates the margins__commodity" do
      margins__commodity = margins__commodity_fixture()

      update_attrs = %{
        adhoc_margin: 456.7,
        cash: 456.7,
        collateral: 456.7,
        debits: 456.7,
        delivery: 456.7,
        enabled: false,
        exposure: 456.7,
        holding_sales: 456.7,
        intraday_payin: 456.7,
        liquid_collateral: 456.7,
        live_balance: 456.7,
        m2m_realised: 456.7,
        m2m_unrealised: 456.7,
        net: 456.7,
        opening_balance: 456.7,
        option_premium: 456.7,
        payout: 456.7,
        span: 456.7,
        stock_collateral: 456.7,
        turnover: 456.7
      }

      assert {:ok, %Margins_Commodity{} = margins__commodity} =
               User__profile.update_margins__commodity(margins__commodity, update_attrs)

      assert margins__commodity.adhoc_margin == 456.7
      assert margins__commodity.cash == 456.7
      assert margins__commodity.collateral == 456.7
      assert margins__commodity.debits == 456.7
      assert margins__commodity.delivery == 456.7
      assert margins__commodity.enabled == false
      assert margins__commodity.exposure == 456.7
      assert margins__commodity.holding_sales == 456.7
      assert margins__commodity.intraday_payin == 456.7
      assert margins__commodity.liquid_collateral == 456.7
      assert margins__commodity.live_balance == 456.7
      assert margins__commodity.m2m_realised == 456.7
      assert margins__commodity.m2m_unrealised == 456.7
      assert margins__commodity.net == 456.7
      assert margins__commodity.opening_balance == 456.7
      assert margins__commodity.option_premium == 456.7
      assert margins__commodity.payout == 456.7
      assert margins__commodity.span == 456.7
      assert margins__commodity.stock_collateral == 456.7
      assert margins__commodity.turnover == 456.7
    end

    test "update_margins__commodity/2 with invalid data returns error changeset" do
      margins__commodity = margins__commodity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               User__profile.update_margins__commodity(margins__commodity, @invalid_attrs)

      assert margins__commodity == User__profile.get_margins__commodity!(margins__commodity.id)
    end

    test "delete_margins__commodity/1 deletes the margins__commodity" do
      margins__commodity = margins__commodity_fixture()

      assert {:ok, %Margins_Commodity{}} =
               User__profile.delete_margins__commodity(margins__commodity)

      assert_raise Ecto.NoResultsError, fn ->
        User__profile.get_margins__commodity!(margins__commodity.id)
      end
    end

    test "change_margins__commodity/1 returns a margins__commodity changeset" do
      margins__commodity = margins__commodity_fixture()
      assert %Ecto.Changeset{} = User__profile.change_margins__commodity(margins__commodity)
    end
  end
end

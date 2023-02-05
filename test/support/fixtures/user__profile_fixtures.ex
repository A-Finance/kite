defmodule Kite.User_ProfileFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kite.User_Profile` context.
  """

  @doc """
  Generate a unique user user_id.
  """
  def unique_user_user_id, do: "some user_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        access_token: "some access_token",
        avatar_url: "some avatar_url",
        broker: "some broker",
        email: "some email",
        enctoken: "some enctoken",
        login_time: "some login_time",
        public_token: "some public_token",
        refresh_token: "some refresh_token",
        user_id: unique_user_user_id(),
        user_name: "some user_name",
        user_shortname: "some user_shortname",
        user_type: "some user_type"
      })
      |> Kite.User_Profile.create_user()

    user
  end

  @doc """
  Generate a margins__equity.
  """
  def margins__equity_fixture(attrs \\ %{}) do
    {:ok, margins__equity} =
      attrs
      |> Enum.into(%{
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
      })
      |> Kite.User__profile.create_margins__equity()

    margins__equity
  end

  @doc """
  Generate a margins__commodity.
  """
  def margins__commodity_fixture(attrs \\ %{}) do
    {:ok, margins__commodity} =
      attrs
      |> Enum.into(%{
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
      })
      |> Kite.User__profile.create_margins__commodity()

    margins__commodity
  end
end

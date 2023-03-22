defmodule Kite.User_Profile do
  import Ecto.Query, warn: false
  alias Kite.Repo

  # ⭐ USER PROFILE
  alias Kite.UserProfile.User

  def list_users do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    user = get_user(attrs["user_id"])

    if user != nil do
      updated_user = update_user(user, attrs)
      {:ok, updated_user}
    else
      user =
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()

      {:ok, user}
    end
  end

  def update_user(%User{} = user, attrs) do
    update_user = User.changeset(user, attrs)

    case Repo.update(update_user) do
      {:ok, user} ->
        user

      {:error, changeset} ->
        changeset
    end
  end

  def get_access_token_for_zerodha(user_id) do
    user = get_user(user_id)

    if user != nil do
      {:ok, user.access_token}
    else
      {:error, "User not logged in"}
    end
  end

  # Returns nil if no result is found
  def get_user(user_id), do: Repo.get_by(User, user_id: user_id)
  # def get_user!(user_id), do: Repo.get_by!(User, user_id: user_id)

  def create_funds_and_margins(user_id, data, segment_type) do
    # "hii" |> IO.inspect()

    case segment_type do
      "equity" ->
        create_margins_equity(user_id, data)

      "commodity" ->
        create_margins_commodity(user_id, data)
    end
  end

  # ⭐ EQUITY

  alias Kite.UserProfile.MarginsEquity

  # make entry of user's funds and margin in equity segment
  def create_margins_equity(user_id, attrs \\ %{}) do
    user = get_user_margins_equity(user_id)

    data = extract_attributes(attrs, user_id)

    if user != nil do
      updated_user_margins_equity = update_user_margins_equity(user, data)

      {:ok, updated_user_margins_equity}
    else
      # "ATTRS" |> IO.inspect()
      # attrs |> IO.inspect()

      user_margins_equity =
        %MarginsEquity{}
        |> MarginsEquity.changeset(data)
        |> Repo.insert()

      {:ok, user_margins_equity}
    end
  end

  def get_user_margins_equity(user_id), do: Repo.get_by(MarginsEquity, user_id: user_id)

  def update_user_margins_equity(%MarginsEquity{} = user_margins_equity, attrs) do
    update_user_margins_equity = MarginsEquity.changeset(user_margins_equity, attrs)

    case Repo.update(update_user_margins_equity) do
      {:ok, user_margins_equity} ->
        user_margins_equity

      {:error, changeset} ->
        changeset
    end
  end

  # Returns the list of margins_equity.
  def list_margins_equity do
    Repo.all(MarginsEquity)
  end

  # ⭐ COMMODITY

  alias Kite.UserProfile.MarginsCommodity

  # make entry of user's funds and margin in commodity segment
  def create_margins_commodity(user_id, attrs \\ %{}) do
    user = get_user_margins_commodity(user_id)

    data = extract_attributes(attrs, user_id)

    if user != nil do
      updated_user_margins_commodity = update_user_margins_commodity(user, data)

      {:ok, updated_user_margins_commodity}
    else
      # "ATTRS" |> IO.inspect()
      # attrs |> IO.inspect()

      user_margins_commodity =
        %MarginsCommodity{}
        |> MarginsCommodity.changeset(data)
        |> Repo.insert()

      {:ok, user_margins_commodity}
    end
  end

  def get_user_margins_commodity(user_id), do: Repo.get_by(MarginsCommodity, user_id: user_id)

  def update_user_margins_commodity(%MarginsCommodity{} = user_margins_commodity, attrs) do
    update_user_margins_commodity = MarginsCommodity.changeset(user_margins_commodity, attrs)

    case Repo.update(update_user_margins_commodity) do
      {:ok, user_margins_commodity} ->
        user_margins_commodity

      {:error, changeset} ->
        changeset
    end
  end

  def list_margins_commodity do
    Repo.all(MarginsCommodity)
  end

  # ⭐ COMMON FOR BOTH COMMODITY AND EQUITY
  def extract_attributes(
        %{"available" => available, "enabled" => enabled, "net" => net, "utilised" => utilised},
        user_id
      ) do
    %{
      "enabled" => enabled,
      "net" => net,
      "user_id" => user_id,
      "adhoc_margin" => available["adhoc_margin"],
      "cash" => available["cash"],
      "collateral" => available["collateral"],
      "intraday_payin" => available["intraday_payin"],
      "live_balance" => available["live_balance"],
      "opening_balance" => available["opening_balance"],
      "debits" => utilised["debits"],
      "delivery" => utilised["delivery"],
      "exposure" => utilised["exposure"],
      "holding_sales" => utilised["holding_sales"],
      "liquid_collateral" => utilised["liquid_collateral"],
      "m2m_realised" => utilised["m2m_realised"],
      "m2m_unrealised" => utilised["m2m_unrealised"],
      "option_premium" => utilised["option_premium"],
      "payout" => utilised["payout"],
      "span" => utilised["span"],
      "stock_collateral" => utilised["stock_collateral"],
      "turnover" => utilised["turnover"]
    }
  end
end
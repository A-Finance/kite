defmodule Kite.User__profile.Margins_Equity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "margins_equity" do
    field(:adhoc_margin, :float)
    field(:cash, :float)
    field(:collateral, :float)
    field(:debits, :float)
    field(:delivery, :float)
    field(:enabled, :boolean, default: false)
    field(:exposure, :float)
    field(:holding_sales, :float)
    field(:intraday_payin, :float)
    field(:liquid_collateral, :float)
    field(:live_balance, :float)
    field(:m2m_realised, :float)
    field(:m2m_unrealised, :float)
    field(:net, :float)
    field(:opening_balance, :float)
    field(:option_premium, :float)
    field(:payout, :float)
    field(:span, :float)
    field(:stock_collateral, :float)
    field(:turnover, :float)
    field(:user_id, :string)

    timestamps()
  end

  @doc false
  def changeset(margins__equity, attrs) do
    margins__equity
    |> cast(attrs, [
      :enabled,
      :net,
      :adhoc_margin,
      :cash,
      :opening_balance,
      :live_balance,
      :collateral,
      :intraday_payin,
      :debits,
      :exposure,
      :m2m_realised,
      :m2m_unrealised,
      :option_premium,
      :payout,
      :span,
      :holding_sales,
      :turnover,
      :liquid_collateral,
      :stock_collateral,
      :delivery,
      :user_id
    ])
    |> validate_required([
      :enabled,
      :net,
      :adhoc_margin,
      :cash,
      :opening_balance,
      :live_balance,
      :collateral,
      :intraday_payin,
      :debits,
      :exposure,
      :m2m_realised,
      :m2m_unrealised,
      :option_premium,
      :payout,
      :span,
      :holding_sales,
      :turnover,
      :liquid_collateral,
      :stock_collateral,
      :delivery,
      :user_id
    ])
    |> unique_constraint(:user_id)
  end
end

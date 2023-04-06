defmodule Kite.Repo.Migrations.CreateMarginsEquity do
  use Ecto.Migration

  def change do
    create table(:margins_equity) do
      add(:enabled, :boolean, default: false, null: false)
      add(:net, :float)
      add(:adhoc_margin, :float)
      add(:cash, :float)
      add(:opening_balance, :float)
      add(:live_balance, :float)
      add(:collateral, :float)
      add(:intraday_payin, :float)
      add(:debits, :float)
      add(:exposure, :float)
      add(:m2m_realised, :float)
      add(:m2m_unrealised, :float)
      add(:option_premium, :float)
      add(:payout, :float)
      add(:span, :float)
      add(:holding_sales, :float)
      add(:turnover, :float)
      add(:liquid_collateral, :float)
      add(:stock_collateral, :float)
      add(:delivery, :float)
      add(:user_id, :string)

      timestamps()
    end

    create(unique_index(:margins_equity, [:user_id]))
  end
end

defmodule Kite.Repo.Migrations.CreateNse do
  use Ecto.Migration

  def change do
    create table(:nse) do
      add :exchange, :string
      add :exchange_token, :string
      add :expiry, :string
      add :instrument_token, :string
      add :instrument_type, :string
      add :last_price, :string
      add :lot_size, :string
      add :name, :string
      add :segment, :string
      add :strike, :string
      add :tick_size, :string
      add :tradingsymbol, :string

      timestamps()
    end

    create(unique_index(:nse, [:exchange_token]))
  end
end

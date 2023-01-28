defmodule Kite.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:user_name, :string)
      add(:user_shortname, :string)
      add(:user_type, :string)
      add(:email, :string)
      add(:access_token, :string)
      add(:api_key, :string)
      add(:avatar_url, :string)
      add(:public_token, :string)
      add(:refresh_token, :string)
      add(:broker, :string)
      add(:enctoken, :string)
      add(:login_time, :string)
      add(:user_id, :string)
      add(:order_types, {:array, :string})
      add(:exchanges, {:array, :string})
      add(:products, {:array, :string})
      add(:meta, {:map, :string})

      timestamps()
    end

    create(unique_index(:users, [:user_id]))
  end
end

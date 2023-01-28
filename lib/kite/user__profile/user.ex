defmodule Kite.User_Profile.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:access_token, :string)
    field(:api_key, :string)
    field(:avatar_url, :string)
    field(:broker, :string)
    field(:email, :string)
    field(:enctoken, :string)
    field(:login_time, :string)
    field(:public_token, :string)
    field(:refresh_token, :string)
    field(:user_id, :string)
    field(:user_name, :string)
    field(:user_shortname, :string)
    field(:user_type, :string)
    field(:order_types, {:array, :string})
    field(:exchanges, {:array, :string})
    field(:products, {:array, :string})
    field(:meta, {:map, :string})

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :user_name,
      :user_shortname,
      :user_type,
      :email,
      :access_token,
      :public_token,
      :refresh_token,
      :broker,
      :enctoken,
      :login_time,
      :user_id,
      :order_types,
      :exchanges,
      :products,
      :meta
    ])
    |> validate_required([
      :user_name,
      :user_shortname,
      :user_type,
      :email,
      :access_token,
      :public_token,
      :broker,
      :enctoken,
      :login_time,
      :user_id,
      :order_types,
      :exchanges,
      :products,
      :meta
    ])
    |> unique_constraint(:user_id)
  end
end

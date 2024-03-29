defmodule Kite.User_Profile do
  @moduledoc """
  The User_Profile context.
  """

  import Ecto.Query, warn: false
  alias Kite.Repo

  alias Kite.User_Profile.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    user = get_user(attrs["user_id"])

    if user != nil do
      updated_user = update_user(user, attrs)
      {:ok, updated_user}
    else
      data =
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end
  end

  @doc """
  Gets a single user.
  """
  # Returns nil if no result is found
  def get_user(user_id), do: Repo.get_by(User, user_id: user_id)
  def get_user!(user_id), do: Repo.get_by!(User, user_id: user_id)

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    update_user = User.changeset(user, attrs)

    case Repo.update(update_user) do
      {:ok, user} ->
        user

      {:error, changeset} ->
        changeset
    end
  end
end

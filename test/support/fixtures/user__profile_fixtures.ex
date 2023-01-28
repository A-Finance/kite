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
end

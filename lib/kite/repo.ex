defmodule Kite.Repo do
  use Ecto.Repo,
    otp_app: :kite,
    adapter: Ecto.Adapters.Postgres
end

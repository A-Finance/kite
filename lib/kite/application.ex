defmodule Kite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KiteWeb.Telemetry,
      # Start the Ecto repository
      Kite.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kite.PubSub},
      # Start Finch
      {Finch, name: Kite.Finch},
      # Start the Endpoint (http/https)
      KiteWeb.Endpoint
      # Start a worker by calling: Kite.Worker.start_link(arg)
      # {Kite.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

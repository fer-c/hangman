# credo:disable-for-this-file
defmodule Hangman.Web.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Hangman.Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Hangman.Web.PubSub},
      # Start the Endpoint (http/https)
      Hangman.Web.Endpoint
      # Start a worker by calling: Hangman.Web.Worker.start_link(arg)
      # {Hangman.Web.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hangman.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Hangman.Web.Endpoint.config_change(changed, removed)
    :ok
  end
end

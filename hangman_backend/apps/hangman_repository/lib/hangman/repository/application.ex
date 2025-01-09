defmodule Hangman.Repository.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    server_config =
      Application.get_env(
        :hangman_repository,
        Hangman.Repository.Runtime.Server
      )

    children = [
      # Starts a worker by calling: Hangman.Repository.Worker.start_link(arg)
      {Hangman.Repository.Runtime.Server, server_config[:args]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hangman.Repository.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

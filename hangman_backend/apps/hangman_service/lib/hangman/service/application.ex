defmodule Hangman.Service.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @super_name GameStarter

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/DynamicSupervisor.html
    # for other strategies and supported options
    supervisor_spec = [
      {DynamicSupervisor, strategy: :one_for_one, name: @super_name}
    ]

    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  @spec start_game() :: :ignore | {:error, any()} | {:ok, pid()} | {:ok, pid(), any()}
  def start_game do
    DynamicSupervisor.start_child(@super_name, {Hangman.Service.Runtime.Server, []})
  end
end

defmodule Hangman.Service.Runtime.Server do
  @moduledoc """
  Documentation for `Hangman.Service.Runtime.Server`.
  """
  alias Hangman.Service.Core.Game
  alias Hangman.Service.Core.GameFactory
  alias Hangman.Service.Runtime.Watchdog

  @type t :: pid()

  # 1 hour
  @idle_timeout 1 * 60 * 60 * 1000

  use GenServer

  ### client process

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  ### server process

  def init(_) do
    watcher = Watchdog.start(@idle_timeout)
    {:ok, {GameFactory.new_game(), watcher}}
  end

  def handle_call({:make_move, guess}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, {updated_game, watcher}}
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {:reply, Game.tally(game), {game, watcher}}
  end
end

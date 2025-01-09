defmodule Hangman.Service.Core.GameFactory do
  @moduledoc """
  Creates a new game from a random word repository.
  """

  require Logger

  alias Hangman.Service.Core.Game

  @spec new_game :: Game.t()
  def new_game do
    repository = Application.get_env(:hangman_service, Hangman.Repository)
    new_game(repository)
  end

  @spec new_game(repository :: module()) :: Game.t()
  def new_game(repository) do
    Logger.debug("Using repository: #{inspect(repository)}")
    word = repository.random_word()
    Logger.debug("Using word: #{inspect(word)}")
    Game.new_game(word)
  end
end

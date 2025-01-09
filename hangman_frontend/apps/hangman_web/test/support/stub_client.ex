defmodule Hangman.Web.Client.Impl.Stub do
  @moduledoc false

  @behaviour Hangman.Client

  @spec new_game(list()) :: Type.game()
  def new_game(_args) do
    :game
  end

  @spec make_move(Type.game(), String.t()) :: Type.tally()
  def make_move(_game, _guess) do
    %{
      id: nil,
      turns_left: 7,
      game_state: :initializing,
      letters: [],
      used: MapSet.new()
    }
  end

  @spec tally(Type.game()) :: Type.tally()
  def tally(_game) do
    %{
      id: nil,
      turns_left: 7,
      game_state: :initializing,
      letters: [],
      used: MapSet.new()
    }
  end
end

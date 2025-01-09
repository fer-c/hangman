defmodule Hangman.Client do
  @moduledoc """
  Documentation for `Hangman.Client`.
  """
  alias Hangman.Client.Type

  @callback new_game(list()) :: Type.game()
  @callback make_move(Type.game(), String.t()) :: Type.tally()
  @callback tally(Type.game()) :: Type.tally()
end

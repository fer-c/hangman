defmodule Hangman.Domain do
  @moduledoc """
  Common definitions for Hangman game in Elixir.
  """

  @type game() :: any()

  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used

  @type tally :: %{
          turns_left: integer,
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }
end

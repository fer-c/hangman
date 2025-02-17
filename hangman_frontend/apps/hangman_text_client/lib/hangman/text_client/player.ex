defmodule Hangman.TextClient.Player do
  @moduledoc false
  alias Hangman.Client.Type

  @type game :: Type.game()
  @type tally :: Type.tally()
  @type state :: {module(), game(), tally()}

  @spec start(module(), game()) :: :ok
  def start(game, client) do
    tally = client.tally(game)
    interact({client, game, tally})
  end

  @spec interact(state()) :: :ok
  def interact({_module, _game, tally = %{game_state: :won}}) do
    IO.puts("Congratulations. You won! The word was #{tally.letters |> Enum.join()}")
  end

  def interact({_module, _game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost... the word was #{tally.letters |> Enum.join()}")
  end

  def interact({module, game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))
    tally = module.make_move(game, get_guess())
    interact({module, game, tally})
  end

  ##################################################

  def feedback_for(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word"
  end

  def feedback_for(%{game_state: :good_guess}), do: "Good guess!"
  def feedback_for(%{game_state: :bad_guess}), do: "Sorry, that letter's not in the word"
  def feedback_for(%{game_state: :already_used}), do: "You already used that letter"

  def current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      "   turns left: ",
      tally.turns_left |> to_string,
      "   used so far: ",
      tally.used |> Enum.join(",")
    ]
  end

  def get_guess do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end

defmodule Hangman.TextClient do
  @moduledoc """
  Documentation for `Hangman.TextClient`.
  """
  @type game :: map()
  @type tally :: map()

  @otp "--otp"
  @wamp "--wamp"

  require Logger

  alias Hangman.Client.Impl, as: ClientImpl
  alias Hangman.TextClient.Player

  def main([]) do
    main([@otp])
  end

  def main([target | rest]) do
    runtime = runtime(target)
    runtime.new_game(rest) |> Player.start(runtime)
  end

  def runtime(@otp), do: ClientImpl.for(:otp)
  def runtime(@wamp), do: ClientImpl.for(:wamp)
end

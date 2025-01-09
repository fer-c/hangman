defmodule Hangman.Client.Impl do
  @moduledoc """
  Returns Implementation module
  """
  def for(:otp), do: Hangman.Client.Impl.OTP
  def for(:wamp), do: Hangman.Client.Impl.WAMP
end

# credo:disable-for-this-file
defmodule Hangman.Web.Live.Game.Header do

  use Hangman.Web, :live_component

  def mount(socket) do
    letters = (?a..?z) |> Enum.map(&<< &1 :: utf8 >>)
    { :ok, assign(socket, :letters, letters) }
  end

  def render(assigns) do
    ~H"""
    <div class="header">
      <h1>Hangman Game</h1>
    </div>
    """
  end
end

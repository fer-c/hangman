defmodule Hangman.Web.Live.Game do
  @moduledoc false

  use Hangman.Web, :live_view

  alias Hangman.Client.Impl, as: ClientImpl

  def mount(_params, _session, socket) do
    runtime =
      Application.get_env(:hangman_web, ClientImpl)

    game = runtime.new_game([])
    tally = runtime.tally(game)
    socket = socket |> assign(%{game: game, tally: tally})
    {:ok, socket}
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    runtime =
      Application.get_env(:hangman_web, ClientImpl)

    tally = runtime.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, :tally, tally)}
  end

  def render(assigns) do
    ~L"""
    <div class="game-holder" phx-window-keyup="make_move">
    <%= live_component(__MODULE__.Header, id: "header") %>
    <%= live_component(__MODULE__.Figure,    tally: assigns.tally, id: 1) %>
    <%= live_component(__MODULE__.Alphabet,  tally: assigns.tally, id: 2) %>
    <%= live_component(__MODULE__.WordSoFar, tally: assigns.tally, id: 3) %>
    </div>
    """
  end
end

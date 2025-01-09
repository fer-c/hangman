# Hangman Game with WAMP

Extension for the Hangman Game used a guidance during the
[_Elixir for Programmers, Second Edition_](https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/)
course by [Dave Thomas](https://github.com/pragdave)

The extension takes the final projects with Phoenix
[code](https://github.com/pragdave/e4p2-hangman/tree/19-04-finish_the_hangman_game)
organized as follow

## Backend Services

Provides the backend services, providing two differnt options.

* **OTP Service**: Runs `Hangman.Service` GenServer in the node `hangman_game_server@$(hostname)`
providing the following API calls:

  * `Hangman.Service, :new_game`: Creates a new Game
  * `game ! {:make_move, guess}`: Makes a guess in a game
  * `game ! {:tally}`: Returns the game gally

* **WAMP Service**: Registers the follow procedures
  * `com.hangman.game.new_game`
  * `com.hangman.game.make_move`
  * `com.hangman.game.tally`

## Frontend Services

Provides client alternatives for clients

* [`hangman_text_client`](hangman_frontend/apps/hangman_text_client): Command line text client with support both backends (otp/wamp)
* [`hangman_web`](hangman_frontend/apps/hangman_web): Phoenix Web Site with support to both backend implementations

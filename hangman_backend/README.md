# Backend Services

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

## Modules

### Repository



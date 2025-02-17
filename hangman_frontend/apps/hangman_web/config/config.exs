# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :hangman_web, Hangman.Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: Hangman.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Hangman.Web.PubSub,
  live_view: [signing_salt: "j4rtY9Sc"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :awre, :erlbin_number, 15

config :wamp_client, :peers, %{
  magenta: %{
    router: :bondy,
    pool_size: 3,
    pool_type: :hash
  }
}

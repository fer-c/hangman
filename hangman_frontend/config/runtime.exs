import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :hangman_web, Hangman.Web.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    secret_key_base: secret_key_base

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :hangman_web, Hangman.Web.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.
end

if config_env() in [:dev, :prod] do
  env = fn
    :charlist, k, d -> System.get_env(k, d) |> String.to_charlist()
    :integer, k, d -> System.get_env(k, d) |> String.to_integer()
    :atom, k, d -> System.get_env(k, d) |> String.downcase() |> String.to_atom()
    :module, k, d -> Module.concat(Elixir, System.get_env(k, d))
    _, k, d -> System.get_env(k, d)
  end

  config :hangman_web, Hangman.Client.Impl, env.(:module, "HANGMAN_CLIENT", "Hangman.Client.Impl.OTP")

  config :wamp_client, :routers, %{
    bondy: %{
      # Erlang string (single quotes)
      hostname: env.(:charlist, "WAMP_HOST", "localhost"),
      port: env.(:integer, "WAMP_PORT", "18082"),
      # Binary string
      realm: env.(:string, "WAMP_REALM", "com.magenta.public"),
      encoding: env.(:atom, "WAMP_ENCODING", "json"),
      reconnect: true,
      reconnect_retries: env.(:integer, "WAMP_RECONNECT_RETRIES", "0"),
      reconnect_max_retries: env.(:integer, "WAMP_RECONNECT_MAX_RETRIES", "0"),
      reconnect_backoff_min: env.(:integer, "WAMP_RECONNECT_BACKOFF_MIN", "500"),
      reconnect_backoff_max: env.(:integer, "WAMP_RECONNECT_BACKOFF_MAX", "30000"),
      reconnect_backoff_type: env.(:atom, "WAMP_RECONNECT_BACKOFF_TYPE", "jitter"),
      auth: %{
        # anonymous (default) | password | wampcra | cryptosign
        method: env.(:atom, "WAMP_AUTH_METHOD", "anonymous"),
        user: env.(:string, "WAMP_AUTH_USERNAME", ""),
        secret: env.(:string, "WAMP_AUTH_PASSWORD", ""),
        pubkey: env.(:string, "WAMP_AUTH_PUBKEY", ""),
        privkey: env.(:string, "WAMP_AUTH_PRIVKEY", "")
      }
    }
  }
end

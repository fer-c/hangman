import Config

if config_env() in [:dev, :prod] do
  env = fn
    :charlist, k, d -> System.get_env(k, d) |> String.to_charlist()
    :integer, k, d -> System.get_env(k, d) |> String.to_integer()
    :atom, k, d -> System.get_env(k, d) |> String.downcase() |> String.to_atom()
    _, k, d -> System.get_env(k, d)
  end

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

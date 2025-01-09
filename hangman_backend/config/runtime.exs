import Config

env = fn
  :charlist, k, d -> System.get_env(k, d) |> String.to_charlist()
  :integer, k, d -> System.get_env(k, d) |> String.to_integer()
  :atom, k, d -> System.get_env(k, d) |> String.downcase() |> String.to_atom()
  _, k, d -> System.get_env(k, d)
end

config :awre,
  erlbin_number: 15,
  agent: :hangman_wamp

config :wamp_client, start: true

config :wamp_client, :defaults, %{
  router: :bondy,
  caller: %{
    features: %{
      progressive_call_results: false,
      progressive_calls: false,
      call_timeout: true,
      call_canceling: false,
      caller_identification: true,
      call_retries: true
    },
    options: %{
      timeout: 15000,
      disclose_me: true
    }
  },
  callee: %{
    features: %{
      progressive_call_results: false,
      progressive_calls: false,
      call_timeout: true,
      call_canceling: false,
      caller_identification: true,
      call_trustlevels: true,
      registration_revocation: true,
      session_meta_api: true,
      pattern_based_registration: true,
      shared_registration: true,
      sharded_registration: true
    },
    options: %{
      disclose_caller: true,
      invoke: :roundrobin
    }
  },
  publisher: %{
    features: %{
      message_retention: true,
      publisher_exclusion: true,
      publisher_identification: true,
      subscriber_blackwhite_listing: true
    }
  },
  subscriber: %{
    features: %{
      event_history: false,
      pattern_based_subscription: true,
      publication_trustlevels: true,
      publisher_identification: true,
      sharded_subscription: true
    }
  }
}

config :wamp_client, :peers, %{
  magenta: %{
    router: :bondy,
    pool_size: 3,
    pool_type: :hash,
    roles: %{
      caller: %{},
      publisher: %{},
      callee: %{
        features: %{},
        registrations: %{
          "com.hangman.game.new_game" => %{
            options: %{
              disclose_caller: true,
              invoke: :roundrobin,
              include_args_on_errors: false
            },
            handler: {Hangman.WAMP, :new_game}
          },
          "com.hangman.game.make_move" => %{
            options: %{disclose_caller: true, invoke: :roundrobin},
            handler: {Hangman.WAMP, :make_move}
          },
          "com.hangman.game.tally" => %{
            options: %{disclose_caller: true, invoke: :roundrobin},
            handler: {Hangman.WAMP, :tally}
          }
        },
        subscriber: %{}
      }
    }
  },
  magenta_subscriber: %{
    router: :bondy,
    pool_size: 1,
    pool_type: :hash,
    roles: %{
      caller: %{},
      publisher: %{},
      callee: %{},
      subscriber: %{
        features: %{},
        subscriptions: %{}
      }
    }
  }
}

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

config :hangman_wamp, Hangman.WAMP.CloakVault,
  ciphers: [
    default: {
      Cloak.Ciphers.AES.GCM,
      tag: "AES.GCM.V1",
      key:
        env.(:string, "CLOAK_KEY", "TYrreA2RKuGyP2/oo1Twhs6ooZFGrkczDfqGdlMQbV8=")
        |> Base.decode64!(),
      iv_length: 12
    }
  ]

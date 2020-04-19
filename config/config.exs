# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cookpod,
  ecto_repos: [Cookpod.Repo]

# Configures the endpoint
config :cookpod, CookpodWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/E/oSpkl32GADMvCfHqYc4tuoyQGjoMpwFGgAsHayFQNmepsyk7MNO00KrpFQB8b",
  render_errors: [view: CookpodWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cookpod.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "Ini669iG"]

config :cookpod,
  basic_auth: [
    username: "user",
    password: "1111",
    realm: "BASIC_AUTH_REALM"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cookpod, CookpodWeb.Gettext, locales: ["en", "ru"], default_locale: "ru"

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :phoenix_slime, :use_slim_extension, true

config :arc,
  # storage: Arc.Storage.S3
  storage: Arc.Storage.Local

# bucket: "cookpod" # if using Amazon S3

# config :ex_aws, :s3,
#   access_key_id: "minio",
#   secret_access_key: "minio111",
#   host: "localhost",
#   port: 9000,
#   region: "local",
#   scheme: "http://",
#   bucket: "cookpod"

# access_key_id: [{:system, "minio"}, :instance_role],
# secret_access_key: [{:system, "minio111"}, :instance_role]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

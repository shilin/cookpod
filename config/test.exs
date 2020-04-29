use Mix.Config

# Configure your database
config :cookpod, Cookpod.Repo,
  username: "postgres",
  password: "postgres",
  database: "cookpod_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cookpod, CookpodWeb.Endpoint,
  http: [port: 4002],
  server: false

config :cookpod,
  basic_auth: [
    username: "user",
    password: "1111",
    realm: "BASIC_AUTH_REALM"
  ]

# Print only warnings and errors during test
config :logger, level: :warn

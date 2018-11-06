use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :skepticapp, Skepticapp.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :skepticapp, Skepticapp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "skepticapp_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :extwitter, :oauth,
  consumer_key: "consumer_key",
  consumer_secret: "consumer_secret",
  access_token: "access_token",
  access_token_secret: "access_token_secret"

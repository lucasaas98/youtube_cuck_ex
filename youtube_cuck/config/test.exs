import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :youtube_cuck, YoutubeCuck.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "youtube_cuck_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :youtube_cuck, YoutubeCuckWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AfaN/I8xJdHHlTjIrCyLcFKQ9ZuZ8Hw759jx8tvbBUxNyZZsNZ5czDUf9FbFh6sA",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :youtube_cuck, Oban, testing: :inline

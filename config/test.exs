import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :cacheable_liveviews, CacheableLiveviews.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "cacheable_liveviews_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cacheable_liveviews, CacheableLiveviewsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "L7BcvsRqHPMV+TRHL37N5yfhFFquScINCB9dWbSSK1BoqDbYTZ3RfWMmNLdSaPXm",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

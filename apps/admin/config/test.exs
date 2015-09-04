use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :emporium_admin, EmporiumAdmin.Endpoint,
  http: [port: 4001],
  server: false

config :emporium_api, EmporiumApi.Endpoint,
  http: [port: 4003],
  server: true

config :emporium_admin,
  api_url: "http://localhost:4003"

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

config :emporium_api, EmporiumApi.Repo,
adapter: Ecto.Adapters.Postgres,
username: "postgres",
password: "",
database: "emporium_api_test",
pool_size: 10

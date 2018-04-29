use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :prater, PraterWeb.Endpoint,
  secret_key_base: "r7X3KKpE6QNedM0yukSKZNkP8LAS5wu12b8HTLfDeWphwfpDatKx9N6xvLcNIvOD"

# Configure your database
config :prater, Prater.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "prater_prod",
  pool_size: 15

import Config

# This file is generated by dockerize. It is used for holding sensitive
# runtime configurations.  For more information about runtime configuration
# for mix release, please check the documentation:
# - https://hexdocs.pm/mix/Mix.Tasks.Release.html#module-runtime-configuration
#
# Example:
#
#    config :my_app, MyApp.Repo,
#      adapter: Ecto.Adapters.Postgres,
#      username: System.fetch_env!("DB_USERNAME"),
#      password: System.fetch_env!("DB_PASSWORD"),
#      hostname: System.fetch_env!("DB_HOSTNAME"),
#      port: System.fetch_env!("DB_PORT"),
#      database: System.fetch_env!("DB_DATABASE"),
#      pool_size: 20

# config :movie_finder_microservices_elixir, :secret_key, System.fetch_env!("MY_APP_SECRET_KEY")
config :movie_finder, port: 8080

config :movie_finder, :downstream_service,
  movie_search_service_url: System.get_env("MOVIE_SEARCH_SERVICE_URL"),
  movie_info_service_url: System.get_env("MOVIE_INFO_SERVICE_URL"),
  artist_info_service_url: System.get_env("ARTIST_INFO_SERVICE_URL")

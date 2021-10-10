use Mix.Config

config :movie_finder_microservices_elixir, port: 8081

config :movie_finder_microservices_elixir, :downstream_service,
  movie_search_service_url: System.get_env("MOVIE_SEARCH_SERVICE_URL"),
  movie_info_service_url: System.get_env("MOVIE_INFO_SERVICE_URL"),
  artist_info_service_url: System.get_env("ARTIST_INFO_SERVICE_URL")

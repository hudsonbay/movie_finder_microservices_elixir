defmodule MovieFinderMicroservicesElixir.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  get "/api/movies" do
    movies = MovieFinder.Movies.list_movies_from_external_service(conn.query_params) |> IO.inspect

    conn
    |> send_resp(
      200,
      Poison.encode!(movies)
    )
  end

  match _ do
    send_resp(conn, 404, "Nothing here :(")
  end
end

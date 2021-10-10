defmodule MovieFinder.Application do
  @moduledoc "OTP Application specification for MovieFinder"

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MovieFinder.Endpoint,
        options: [port: Application.get_env(:movie_finder, :port)]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MovieFinder.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule MovieFinderMicroservicesElixir.Application do
  @moduledoc "OTP Application specification for MovieFinderMicroservicesElixir"

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MovieFinderMicroservicesElixir.Endpoint,
        options: [port: 8080]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MovieFinderMicroservicesElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule MovieFinder.MixProject do
  use Mix.Project

  def project do
    [
      app: :movie_finder,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {MovieFinder.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.8"}
    ]
  end
end

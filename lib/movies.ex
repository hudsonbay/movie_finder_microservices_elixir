defmodule MovieFinder.Movies do
  @moduledoc """
  Module for requesting the movie downstream services
  """

  @downstream_service Application.get_env(:movie_finder, :downstream_service)

  def list_movies_from_external_service(params) do
    url = @downstream_service[:movie_search_service_url] <> "/movies?" <> URI.encode_query(params)

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        movies =
          Poison.decode!(body)
          |> get_movies_info()

        %{
          data: %{
            movies: movies
          },
          metadata: params,
          errors: log_errors(movies)
        }

      {:ok, %HTTPoison.Response{body: "Internal Server Error", status_code: status_code}} ->
        %{"error" => "Internal Server Error from the movies server", "status_code" => status_code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Fetches a movie's info by making a request to the MOVIE INFO SERVICE
  """
  def get_movies_info(movies) do
    ids =
      movies
      |> Map.get("data")
      |> Enum.take(5)
      |> Enum.join(",")

    url = @downstream_service[:movie_info_service_url] <> "/movies" <> "?ids=" <> ids

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
        |> Map.get("data")
        |> build_movies()
        |> Enum.map(fn m -> insert_cast_to_movie(m) end)
        |> Enum.map(fn m -> insert_genres_to_movie(m) end)

      {:ok, %HTTPoison.Response{body: "Internal Server Error", status_code: status_code}} ->
        %{
          "error" => "Internal Server Error from the movies info server",
          "status_code" => status_code
        }

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Replaces the cast attribute with the one fetched from the Artist info service
  """
  def insert_cast_to_movie(movie) do
    cast = get_cast_info(movie)
    Map.replace(movie, "cast", cast)
  end

  @doc """
  Fetches the cast info of a movie by making a request to the ARTIST INFO SERVICE
  """
  def get_cast_info(movie) do
    ids =
      movie
      |> Map.get("cast")
      |> Enum.take(5)
      |> Enum.join(",")

    url =
      @downstream_service[:artist_info_service_url] <>
        "/artists" <> "?ids=" <> ids

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
        |> Map.get("data")
        |> build_cast()

      {:ok, %HTTPoison.Response{body: "Internal Server Error", status_code: status_code}} ->
        %{
          "error" => "Internal Server Error from the artist info server",
          "status_code" => status_code
        }

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Modifies the artist struct and returns a new struct without including the movies
  of each artist
  """
  def build_cast(arr) when is_list(arr) do
    Enum.map(arr, fn x -> Map.delete(x, "movies") end)
  end

  @doc """
  Modifies the movie struct and returns a new struct leaving only the specified fields
  """
  def build_movies(arr) when is_list(arr) do
    Enum.map(arr, fn x ->
      x
      |> Map.delete("originalLanguage")
      |> Map.delete("overview")
      |> Map.delete("popularity")
      |> Map.delete("releaseDate")
      |> Map.delete("runtime")
      |> Map.delete("tagline")
    end)
  end

  def insert_genres_to_movie(movie) do
    genres = get_genres_info(movie)
    Map.replace(movie, "genres", genres)
  end

  @doc """
  Obtains the genres from a movie by reading from the genres.json file
  """
  def get_genres_info(movie) do
    with {:ok, body} <- "priv/seeds/genres.json" |> Path.expand() |> File.read() do
      genres = Poison.decode!(body)

      movie
      |> Map.get("genres")
      |> Enum.map(fn x -> find_genre_by_id(genres, x) end)
    end
  end

  @doc """
  Finds the genre name by genre id
  """
  def find_genre_by_id(genres, id) do
    Enum.find(genres, fn genre -> genre["id"] == id end) |> Map.get("name")
  end

  @doc """
  Collects all the errors in the HTTP request
  """
  def log_errors(movies) do
    case movies do
      %{
        "error" => "Internal Server Error from the movies search server",
        "status_code" => 500
      } ->
        [
          %{
            "error" => "Internal Server Error from the movies search server",
            "status_code" => 500
          }
        ]

      %{
        "error" => "Internal Server Error from the movies info server",
        "status_code" => 500
      } ->
        [
          %{
            "error" => "Internal Server Error from the movies info server",
            "status_code" => 500
          }
        ]

      _ ->
        find_cast_errors(movies)
    end
  end

  @doc """
  Search through all the movies looking for errors with `cast` attribute.
  Returns a list of this type:
    [
        {
            "errorCode": 440,
            "message": "Movie id #1000 cast info is not complete"
        },...
    ]
  """
  def find_cast_errors(movies) do
    Enum.filter(movies, fn x ->
      x |> Map.get("cast") == %{
        "error" => "Internal Server Error from the artist info server",
        "status_code" => 500
      }
    end)

    movies
    |> Enum.filter(fn x ->
      Map.get(x, "cast") == %{
        "error" => "Internal Server Error from the artist info server",
        "status_code" => 500
      }
    end)
    |> Enum.map(fn x ->
      %{
        errorCode:
          x
          |> Map.get("cast")
          |> Map.get("status_code"),
        message: "Movie id ##{x["id"]} cast info is not complete"
      }
    end)
  end
end

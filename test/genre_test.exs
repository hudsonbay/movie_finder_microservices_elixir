defmodule MovieFinder.GenresTest do
  use ExUnit.Case
  alias MovieFinder.Movies

  test "should obtain the genres from a movie by reading from the genres.json file" do
    assert Movies.get_genres_info(%{
             "budget" => 115_000_000,
             "cast" => [3896, 3061, 524, 33196, 27762, 6, 130],
             "genres" => [12, 28, 878],
             "id" => 1893,
             "originalLanguage" => "en",
             "overview" =>
               "Anakin Skywalker, a young slave strong with the Force, is discovered on Tatooine. Meanwhile, the evil Sith have returned, enacting their plot for revenge against the Jedi.",
             "popularity" => 22.71543,
             "posterPath" => "https://image.tmdb.org/t/p/w342/n8V09dDc02KsSN6Q4hC2BX6hN8X.jpg",
             "releaseDate" => "1999-05-19",
             "revenue" => 924_317_558,
             "runtime" => 136,
             "tagline" =>
               "Every generation has a legend. Every journey has a first step. Every saga has a beginning.",
             "title" => "Star Wars: Episode I - The Phantom Menace"
           }) == ["Adventure", "Action", "Science Fiction"]
  end
end

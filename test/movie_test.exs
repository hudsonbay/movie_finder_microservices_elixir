defmodule MovieFinder.MoviesTest do
  use ExUnit.Case
  alias MovieFinder.Movies
  alias MovieFinder.Test.{CastFixtures, GenreFixtures, MovieFixtures}

  test "should modifiy the artist struct and returns a new struct without including the movies
  of each artist" do
    assert Movies.build_cast(CastFixtures.cast_fixture()) == [
             %{
               "gender" => 2,
               "id" => "13",
               "name" => "Albert Brooks",
               "profilePath" => "https://image.tmdb.org/t/p/w185/kahlMTdygrPJ28VYRhKPavYD9hs.jpg"
             },
             %{
               "gender" => 1,
               "id" => "14",
               "name" => "Ellen DeGeneres",
               "profilePath" => "https://image.tmdb.org/t/p/w185/wBB6C4IGsYlHzIEMW6Q3JIvNAfz.jpg"
             },
             %{
               "gender" => 2,
               "id" => "12",
               "name" => "Alexander Gould",
               "profilePath" => "https://image.tmdb.org/t/p/w185/c4EHOhxzwx7uDBxC8zODvKAEFGX.jpg"
             },
             %{
               "gender" => 2,
               "id" => "5293",
               "name" => "Willem Dafoe",
               "profilePath" => "https://image.tmdb.org/t/p/w185/7t8fhfaFBoS9VOo3OPXCfK516eI.jpg"
             }
           ]
  end

  test "should modify the movie struct and returns a new struct leaving only the specified fields" do
    assert Movies.build_movies(MovieFixtures.movie_fixture()) == [
             %{
               "budget" => 115_000_000,
               "cast" => [3896, 3061, 524, 33196, 27762, 6, 130],
               "genres" => [12, 28, 878],
               "id" => 1893,
               "posterPath" => "https://image.tmdb.org/t/p/w342/n8V09dDc02KsSN6Q4hC2BX6hN8X.jpg",
               "revenue" => 924_317_558,
               "title" => "Star Wars: Episode I - The Phantom Menace"
             },
             %{
               "budget" => 8_000_000,
               "cast" => [8891, 2231, 139, 62, 10182, 1037, 7036],
               "genres" => '5P',
               "id" => 680,
               "posterPath" => "https://image.tmdb.org/t/p/w342/dM2w364MScsjFf8pfMbaWUcWrR.jpg",
               "revenue" => 213_928_762,
               "title" => "Pulp Fiction"
             },
             %{
               "budget" => 94_000_000,
               "cast" => [13, 14, 12, 5293, 18, 19, 17401],
               "genres" => [16, 10751],
               "id" => 12,
               "posterPath" => "https://image.tmdb.org/t/p/w342/syPWyeeqzTQIxjIUaIFI7d0TyEY.jpg",
               "revenue" => 940_335_536,
               "title" => "Finding Nemo"
             }
           ]
  end

  test "should find the genre name given its id" do
    assert Movies.find_genre_by_id(GenreFixtures.genre_fixture(), 28) == "Action"
    assert Movies.find_genre_by_id(GenreFixtures.genre_fixture(), 9648) == "Mystery"
    assert Movies.find_genre_by_id(GenreFixtures.genre_fixture(), 37) == "Western"
    assert Movies.find_genre_by_id(GenreFixtures.genre_fixture(), 16) == "Animation"
  end
end

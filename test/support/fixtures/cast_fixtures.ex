defmodule MovieFinder.Test.CastFixtures do
  def cast_fixture() do
    [
      %{
        "gender" => 2,
        "id" => "13",
        "movies" => '\f',
        "name" => "Albert Brooks",
        "profilePath" => "https://image.tmdb.org/t/p/w185/kahlMTdygrPJ28VYRhKPavYD9hs.jpg"
      },
      %{
        "gender" => 1,
        "id" => "14",
        "movies" => '\f',
        "name" => "Ellen DeGeneres",
        "profilePath" => "https://image.tmdb.org/t/p/w185/wBB6C4IGsYlHzIEMW6Q3JIvNAfz.jpg"
      },
      %{
        "gender" => 2,
        "id" => "12",
        "movies" => '\f',
        "name" => "Alexander Gould",
        "profilePath" => "https://image.tmdb.org/t/p/w185/c4EHOhxzwx7uDBxC8zODvKAEFGX.jpg"
      },
      %{
        "gender" => 2,
        "id" => "5293",
        "movies" => [12, 557, 311_324, 406_990, 392_044, 245_891],
        "name" => "Willem Dafoe",
        "profilePath" => "https://image.tmdb.org/t/p/w185/7t8fhfaFBoS9VOo3OPXCfK516eI.jpg"
      }
    ]
  end
end

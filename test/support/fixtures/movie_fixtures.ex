defmodule MovieFinder.Test.MovieFixtures do
  def movie_fixture() do
    [
      %{
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
      },
      %{
        "budget" => 8_000_000,
        "cast" => [8891, 2231, 139, 62, 10182, 1037, 7036],
        "genres" => '5P',
        "id" => 680,
        "originalLanguage" => "en",
        "overview" =>
          "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
        "popularity" => 22.685188,
        "posterPath" => "https://image.tmdb.org/t/p/w342/dM2w364MScsjFf8pfMbaWUcWrR.jpg",
        "releaseDate" => "1994-09-10",
        "revenue" => 213_928_762,
        "runtime" => 154,
        "tagline" => "Just because you are a character doesn't mean you have character.",
        "title" => "Pulp Fiction"
      },
      %{
        "budget" => 94_000_000,
        "cast" => [13, 14, 12, 5293, 18, 19, 17401],
        "genres" => [16, 10751],
        "id" => 12,
        "originalLanguage" => "en",
        "overview" =>
          "Nemo, an adventurous young clownfish, is unexpectedly taken from his Great Barrier Reef home to a dentist's office aquarium. It's up to his worrisome father Marlin and a friendly but forgetful fish Dory to bring Nemo home -- meeting vegetarian sharks, surfer dude turtles, hypnotic jellyfish, hungry seagulls, and more along the way.",
        "popularity" => 22.619522,
        "posterPath" => "https://image.tmdb.org/t/p/w342/syPWyeeqzTQIxjIUaIFI7d0TyEY.jpg",
        "releaseDate" => "2003-05-30",
        "revenue" => 940_335_536,
        "runtime" => 100,
        "tagline" => "There are 3.7 trillion fish in the ocean. They're looking for one.",
        "title" => "Finding Nemo"
      }
    ]
  end
end

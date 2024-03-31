# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require 'json'
require 'net/http'

List.destroy_all
puts "Lists are destroyed"
puts "Creating new movies and new lists"

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_api = URI.open(url).read
@movies= JSON.parse(movie_api)

@movies["results"].each do |movie|
  Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}", rating: movie["vote_average"] )
  puts "#{movie["title"]} is create"
end


# movie_one = Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# puts "#{movie_one.title} is created"
# movie_two = Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# puts "#{movie_two.title} is created"
# movie_three = Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# puts "#{movie_three.title} is created"
# movie_four =Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
# puts "#{movie_four.title} is created"

file_one = URI.open("https://res.cloudinary.com/doulf2cl1/image/upload/v1711535184/nature-3102762_1280_u7agzl.jpg")
file_two = URI.open("https://res.cloudinary.com/doulf2cl1/image/upload/v1711535414/Screenshot_2024-03-27_at_19.29.40_y4pode.png")
file_three = URI.open("https://res.cloudinary.com/doulf2cl1/image/upload/v1711852692/anime_zbwsnd.jpg")


lists = [{
  name: "Drama",
  io: file_one,
  filename: "drama.jpg",
  content_type: "image/jpg"
  },
  {
  name: "Action",
  io: file_two,
  filename: "action.png",
  content_type: "image/png"
  },
  {
  name: "Anime",
  io: file_three,
  filename: "anime.jpg",
  content_type: "image/png"
  }
]

main_list = []
lists.each do |item|
  # starting_time = start_times.sample
  # Random datetime instance with set parameters from start_times array
  e = List.create!(
    name: item[:name]
  )
  puts "Attaching photos to #{e.name} "
  e.photo.attach(io: item[:io], filename: item[:filename], content_type: item[:content_type])
  main_list << e
  puts "Event -> #{e.name} has been created"
end

puts "#{main_list.count} lists generated 🤹"

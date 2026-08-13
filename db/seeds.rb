require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   THE end

# 1 - CLEAN db
puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

# 2 - CREATE instances
#   2-1 MOVIES
puts "Creating movies..."
Movie.create!(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create!(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create!(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

20.times do
  begin
    Movie.create!(
      title: Faker::Movie.unique.title,
      overview: Faker::Lorem.paragraph(sentence_count: 3),
      poster_url: "https://picsum.photos/seed/#{rand(1000)}/300/450",
      rating: rand(1.0..10.0).round(1)
    )
  rescue ActiveRecord::RecordInvalid
    next
  end
end

#   2-2 LISTS
puts "Creating lists..."
List.create!(name: "Drama")
List.create!(name: "Comedy")
List.create!(name: "Classic")
List.create!(name: "To rewatch")
List.create!(name: "Girl Power")

#   2-3 BOOKMARKS
puts "Creating bookmarks..."
wonder_woman = Movie.find_by(title: "Wonder Woman 1984")
shawshank = Movie.find_by(title: "The Shawshank Redemption")

girl_power = List.find_by(name: "Girl Power")
drama = List.find_by(name: "Drama")

Bookmark.create!(movie: wonder_woman, list: girl_power, comment: "Alan Turing recommended this movie")
Bookmark.create!(movie: shawshank, list: drama, comment: "A true classic, must watch")

# 3 - DISPLAY message
puts "Finished! Created #{Movie.count} movies, #{List.count} and #{Bookmark.count} lists."

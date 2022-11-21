# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require "open-uri"

puts "Cleaning up database..."

Offer.destroy_all
Artwork.destroy_all
User.destroy_all

puts "Database cleaned"

puts "Populating user seeds"
User.create!(
  email: "kenneth@gmail.com",
  password: "password",
  password_confirmation: "password",
  first_name: "Kenneth",
  last_name: "Chien"
)
User.create!(
  email: "jega@gmail.com",
  password: "password",
  password_confirmation: "password",
  first_name: "Jega",
  last_name: "Pradeeba"
)
User.create!(
  email: "christina@gmail.com",
  password: "password",
  password_confirmation: "password",
  first_name: "Christina",
  last_name: "Choi"
)
User.create!(
  email: "mike@gmail.com",
  password: "password",
  password_confirmation: "password",
  first_name: "Michael",
  last_name: "Thomas"
)

puts "Populating artworks seeds"
id_range = User.last.id - User.first.id
50.times do
  file = URI.open("https://source.unsplash.com/random?sig=#{rand(1000..100000000)}")
  new_artwork = Artwork.new(
    artist_name: Faker::Artist.name.gsub("\u0000", ''),
    title: Faker::Game.title.gsub("\u0000", ''),
    theme: %w[Contemporary Street-Art Pop-Art Abstract-Expressionism Post-War Impressionism Old-Masters].sample,
    year: rand(1500..2022),
    price: rand(1..10_000_000),
    details: Faker::Quote.famous_last_words,
    owner_id: User.first.id + rand(0..id_range)
  )

  new_artwork.photo.attach(io: File.open(file.path), filename: "nes.png", content_type: "image/png")
  new_artwork.save!
  puts "succesfully created new artwork #{new_artwork.id}"
end

puts "Populating offers"
id_range = User.last.id - User.first.id
artwork_range = Artwork.last.id - Artwork.first.id
20.times do
  artwork_id = Artwork.first.id + rand(1..artwork_range)
  # if !Offer.where(buyer_id: artWorkID).exists?
  Offer.create!(
    amount: Artwork.find(artwork_id).price * 0.9,
    artwork_id:,
    buyer_id: User.first.id + rand(0..id_range),
    status: "pending"
  )
end

puts "Seeding completed"

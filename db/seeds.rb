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
5.times do
  password = Faker::Internet.password
  User.create!(
  email: Faker::Internet.safe_email,
  password: "password",
  password_confirmation: "password",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
  )
end


  puts "Populating artworks seeds"
  id_range = User.last.id - User.first.id
  20.times do |count|
    file = URI.open("https://source.unsplash.com/random")
    new_artwork = Artwork.new(
        artist_name: Faker::Artist.name.gsub("\u0000", ''),
        title: Faker::Game.title.gsub("\u0000", ''),
        theme: Faker::Game.genre.gsub("\u0000", ''),
        year: rand(1500..2022),
        price: rand(1..10000000),
        details: Faker::Quote.famous_last_words,
        owner_id: User.first.id + rand(1..id_range)
      )
      new_artwork.photo.attach(io: File.open(file.path), filename: "nes.png", content_type: "image/png")
      new_artwork.save!
      puts "succesfully created new artwork #{new_artwork.id}"
    end


puts "Populating offers"
id_range = User.last.id - User.first.id
artwork_range = Artwork.last.id - Artwork.first.id
50.times do |count|
  artWorkID = Artwork.first.id + rand(1..artwork_range)
  # if !Offer.where(buyer_id: artWorkID).exists?
  Offer.create!(
    amount: Artwork.find(artWorkID).price*0.9,
    artwork_id: artWorkID,
    buyer_id: User.first.id + rand(1..id_range),
    status: "pending")
    # owner_id: User.find(RandomId)                )
  end

puts "Seeding completed"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
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
  Artwork.create!(
    artist_name: Faker::Artist.name.gsub("\u0000", ''),
    title: Faker::Game.title.gsub("\u0000", ''),
    theme: Faker::Game.genre.gsub("\u0000", ''),
    year: rand(1500..2022),
    price: rand(1..10000000),
    details: Faker::Quote.famous_last_words,
    owner_id: User.first.id + rand(1..id_range)
  )
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


# create_table "offers", force: :cascade do |t|
#   t.integer "amount"
#   t.bigint "artwork_id"
#   t.bigint "buyer_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["artwork_id"], name: "index_offers_on_artwork_id"
#   t.index ["buyer_id"], name: "index_offers_on_buyer_id"
# end

# # 10.times do |count|
# {
# # create artworks
# # @artwork = Artwork.new(xxxx)
# # create user
# # @user = User.new(xxx)
# # create offers
#   @offer = Offer.new(xxx)
#   @offer.artwork = @artwork
#   @offer.user = @user


# }

class Artwork < ApplicationRecord

  validates :artist_name, :title, :theme, :year, :price, :details, presence: true

  belongs_to :user
end

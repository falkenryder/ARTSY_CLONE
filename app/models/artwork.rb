class Artwork < ApplicationRecord
  validates :artist_name, :title, :theme, :year, :price, :details, presence: true

  has_one_attached :photo

  # belongs_to :owner, class_name: "User"
  has_many :offers, dependent: :destroy
end

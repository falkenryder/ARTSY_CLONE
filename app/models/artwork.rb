class Artwork < ApplicationRecord
  validates :artist_name, :title, :theme, :year, :price, :details, presence: true

  belongs_to :owner, class: "User"
  has_many :offers, dependent: :destroy
end

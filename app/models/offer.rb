class Offer < ApplicationRecord
  validates :amount, presence: true

  belongs_to :artwork
  belongs_to :buyer, class_name: "User"
end

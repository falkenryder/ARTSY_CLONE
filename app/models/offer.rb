class Offer < ApplicationRecord
  validates :amount, :status, presence: true
  validates :status, inclusion: { in: %w[pending accepted rejected] }

  belongs_to :artwork
  belongs_to :buyer, class_name: "User"
end

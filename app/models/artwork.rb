class Artwork < ApplicationRecord
  validates :artist_name, :title, :theme, :year, :price, :details, presence: true
  validates :theme, inclusion: { in: %w[Contemporary Street-Art Pop-Art Abstract-Expressionism Post-War Impressionism Old-Masters] }

  has_one_attached :photo

  # belongs_to :owner, class_name: "User"
  has_many :offers, dependent: :destroy
end

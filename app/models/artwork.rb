class Artwork < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by,
                  against: %i[artist_name title year theme],
                  using: { trigram: { threshold: 0.1 } }

  include ActionView::Helpers::NumberHelper

  validates :artist_name, :title, :theme, :year, :price, :details, presence: true
  validates :theme, inclusion: { in: %w[Contemporary Street-Art Pop-Art Abstract-Expressionism Post-War Impressionism Old-Masters] }

  has_one_attached :photo

  # belongs_to :owner, class_name: "User"
  has_many :offers, dependent: :destroy

  def price_delimit
    return "#{number_with_delimiter(self.price)}"
  end

end

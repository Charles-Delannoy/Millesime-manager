class Wine < ApplicationRecord
  has_many :bottles
  has_many :assemblages
  has_many :pairings
  has_one_attached :photo
  validates :name, :millesime, :apogee_start, :apogee_end, :color, :degree, presence: true
end

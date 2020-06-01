class Wine < ApplicationRecord
  has_many :bottles
  has_many :assemblages
  has_many :pairings
  belongs_to :castle
  belongs_to :appelation
  has_one_attached :photo
  has_many :reviews
  validates :name, :millesime, :apogee_start, :apogee_end, :color, :degree, presence: true
end

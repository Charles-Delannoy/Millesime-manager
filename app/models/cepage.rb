class Cepage < ApplicationRecord
  has_many :assemblages
  validates :name, uniqueness: true, presence: true
end

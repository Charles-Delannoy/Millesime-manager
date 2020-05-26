class Meal < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :pairings
end

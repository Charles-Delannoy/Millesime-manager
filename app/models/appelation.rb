class Appelation < ApplicationRecord
  belongs_to :region
  validates :name, uniqueness: true, presence: true
end

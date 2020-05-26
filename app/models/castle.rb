class Castle < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :wines
end

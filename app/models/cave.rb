class Cave < ApplicationRecord
  belongs_to :user
  has_many :bottles

  has_one_attached :photo
  validates :name, presence: true
end

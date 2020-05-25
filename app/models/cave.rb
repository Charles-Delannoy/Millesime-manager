class Cave < ApplicationRecord
  belongs_to :user
  has_many :bottles
end

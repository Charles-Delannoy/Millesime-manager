class Bottle < ApplicationRecord
  belongs_to :wine
  belongs_to :cave
end

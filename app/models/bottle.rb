class Bottle < ApplicationRecord
  belongs_to :wine
  belongs_to :cave

  scope :wine_apogee, -> { joins(:wine).where('wines.apogee_start <= :date AND wines.apogee_end >= :date', date: Time.now.year)}
end

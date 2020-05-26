class Wine < ApplicationRecord
  has_many :bottles
  has_many :assemblages
  # def set_apogee
  #   #Bordeaux
  #   bx_rouge_appelations = {'bordeaux' => [5, 6],
  #                           'bordeaux supérieur' => [5, 6]
  #                           'haut médoc' => [8, 15]
  #                           'graves' => [8, 15]
  #                           'pauillac' => [10, 20]}
  #   #Bourgogne
  #   #Rhone
  #   #Loire
  #   #Alsace
  #   #sud-ouest
  #   #mediterranee

  # end
end

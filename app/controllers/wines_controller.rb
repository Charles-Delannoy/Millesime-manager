class WinesController < ApplicationController

  def index
    @wines = policy_scope(Wine)
  end

  def show
    @wine = Wine.find(params['id'])
    @assemblages = Assemblage.where(wine: @wine)
    @pairings = Pairing.where(wine: @wine)
    authorize @wine
  end

end

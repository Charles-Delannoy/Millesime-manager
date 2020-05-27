class WinesController < ApplicationController

  def index
    @wines = policy_scope(Wine)
  end

  def show
    @wine = Wine.find(params['id'])
    authorize @wine
  end

end

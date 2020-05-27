class BottlesController < ApplicationController

  def new
    @caves = Cave.where(user: current_user)
    @wine = Wine.find(params['wine_id'])
    @bottle = Bottle.new()
    authorize @bottle
  end

  def create
    @wine = Wine.find(params['wine_id'])
    @bottle = Bottle.new(bottle_params)
    authorize @bottle
    @cave = Cave.find(params[:bottle][:cave])
    @bottle.wine = @wine
    @bottle.cave = @cave
    @bottle.save ? (redirect_to cave_path(@cave)) : (render :new)
  end

  private

  def bottle_params
    params.require(:bottle).permit(:quantity)
  end

end

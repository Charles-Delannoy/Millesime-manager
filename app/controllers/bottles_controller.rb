class BottlesController < ApplicationController

  def new
    @cave = Cave.find(params[:cave_id]) if params[:cave_id]
    @caves = Cave.where(user: current_user)
    @wine = Wine.find(params[:wine_id])
    @bottle = Bottle.new(cave: @cave)
    authorize @bottle
  end

  def show
    @bottle = Bottle.find(params[:id])
    @wine = @bottle.wine
    @assemblages = Assemblage.where(wine: @wine)
    @pairings = Pairing.where(wine: @wine)
    authorize @bottle
  end

  def create
    @wine = Wine.find(params[:wine_id])
    @cave = Cave.find(params[:bottle][:cave_id])
    existing_bottle = @cave.bottles.where(wine: @wine)
    if existing_bottle.empty?
      @bottle = Bottle.new(bottle_params)
      @bottle.wine = @wine
      @bottle.cave = @cave
    else
      @bottle = existing_bottle[0]
      @bottle.quantity += params[:bottle][:quantity].to_i
    end
      authorize @bottle
    @bottle.save ? (redirect_to cave_path(@cave)) : (render :new)
  end

  def edit
    @bottle = Bottle.find(params[:id])
    authorize @bottle
  end

  def update
    @bottle = Bottle.find(params[:id])
    authorize @bottle
    @bottle.quantity -= bottle_params[:quantity].to_i
    @bottle.save ? (redirect_to cave_path(@bottle.cave)) : (render :new)
  end

  private

  def bottle_params
    params.require(:bottle).permit(:quantity)
  end

end

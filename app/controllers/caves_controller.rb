class CavesController < ApplicationController

  def index
    @caves = policy_scope(Cave).where(user: current_user)
  end

  def new
    @cave = Cave.new
    authorize @cave
  end

  def show
    @cave = Cave.find(params['id'])
    @bottles = Bottle.where(cave: @cave)
    authorize @cave
  end

  def create
    @cave = Cave.new(cave_params)
    @cave.user = current_user
    if @cave.save
      redirect_to caves_path
    else
      render :new
    end
  end

  private

  def set_cave
    @cave = Cave.find(params[:id])
  end

  def cave_params
    params.require(:cave).permit(:name)
  end
end

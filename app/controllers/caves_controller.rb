class CavesController < ApplicationController

  before_action :set_cave, only: [:show, :edit, :update]

  def index
    @caves = policy_scope(Cave).where(user: current_user)
  end

  def new
    @cave = Cave.new
    authorize @cave
  end

  def show
    @bottles = Bottle.where(cave: @cave)
    authorize @cave
  end

  def create
    @cave = Cave.new(cave_params)
    authorize @cave
    @cave.user = current_user
    if @cave.save
      redirect_to caves_path
    else
      render :new
    end
  end

  def edit
    authorize @cave
  end

  def update
    authorize @cave
    @cave.update(cave_params)
    if @cave.save
      redirect_to caves_path(@cave)
    else
      render :new
    end
  end

  private

  def set_cave
    @cave = Cave.find(params[:id])
  end

  def cave_params
    params.require(:cave).permit(:name, :photo)
  end
end

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
    @meals = Meal.order(name: :asc)
    @appelations = Appelation.order(name: :asc)
    @regions = Region.order(name: :asc)
    @options = {}
    @options[:pairings] = {meal_id: params[:meal]} if params[:meal].present?
    @options[:appelations] = {region_id: params[:region]} if params[:region].present?
    @options[:appelation_id] = params[:appelation] if params[:appelation].present?
    if @options.any?
      @redbottles = @cave.bottles.includes(wine: [:pairings, :appelation]).where(wines: @options.merge(color: 'Rouge')).where('wines.apogee_start <= :date AND wines.apogee_end >= :date', date: Time.now.year)
      @whitebottles = @cave.bottles.includes(wine: [:pairings, :appelation]).where(wines: @options.merge(color: 'Blanc')).where('wines.apogee_start <= :date AND wines.apogee_end >= :date', date: Time.now.year)
      @pinkbottles = @cave.bottles.includes(wine: [:pairings, :appelation]).where(wines: @options.merge(color: 'Rosé')).where('wines.apogee_start <= :date AND wines.apogee_end >= :date', date: Time.now.year)
    else
      @redbottles = @cave.bottles.includes(:wine).where(wines: {color: 'Rouge'})
      @whitebottles = @cave.bottles.includes(:wine).where(wines: {color: 'Blanc'})
      @pinkbottles = @cave.bottles.includes(:wine).where(wines: {color: 'Rosé'})
    end
    authorize @cave
  end

  def create
    @cave = Cave.new(cave_params)
    authorize @cave
    @cave.user = current_user
    if @cave.save
      redirect_to cave_path(@cave)
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

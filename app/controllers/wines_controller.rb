class WinesController < ApplicationController

  def index
    @cave = Cave.find(params[:cave_id]) if params[:cave_id].present?
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @wines = policy_scope(Wine).where(sql_query, query: "%#{params[:query]}%").sort_by{ |wine| wine.millesime}.reverse
    else
      @wines = policy_scope(Wine).sort_by{ |wine| wine.millesime}.reverse
    end
  end

  def show
    @cave = Cave.find(params[:cave_id]) if params[:cave_id].present?
    @wine = Wine.find(params[:id])
    @assemblages = Assemblage.where(wine: @wine)
    @pairings = Pairing.where(wine: @wine)
    authorize @wine
  end
end

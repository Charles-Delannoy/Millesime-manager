class WinesController < ApplicationController

  def index
    @cave = Cave.find(params[:cave_id]) if params[:cave_id].present?
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @wines = policy_scope(Wine).where(sql_query, query: "%#{params[:query]}%")
    else
      @wines = policy_scope(Wine)
    end
  end

  def show
    @wine = Wine.find(params['id'])
    @assemblages = Assemblage.where(wine: @wine)
    @pairings = Pairing.where(wine: @wine)
    authorize @wine
  end

end

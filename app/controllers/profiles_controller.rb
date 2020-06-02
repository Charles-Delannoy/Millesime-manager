class ProfilesController < ApplicationController

  def index
    policy_scope(User)
    @cave = Cave.find(params[:cave_id]) if params[:cave_id].present?
  end

end

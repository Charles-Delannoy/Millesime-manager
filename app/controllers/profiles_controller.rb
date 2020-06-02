class ProfilesController < ApplicationController

  def index
    policy_scope(User)
    @cave = Cave.find(params[:cave_id]) if params[:cave_id].present?
    @wines = Wine.includes(:cave).where(caves: {user: current_user})
  end

  def edit
    authorize current_user
  end

  def update
    authorize current_user
    current_user.update(profil_params)
    if current_user.save
      redirect_to profile_path(current_user)
    else
      render :new
    end
  end

end

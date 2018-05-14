class UsersController < ApplicationController
  before_action :require_admin! # your authorization method

  def index
    @users = User.order(:id)
  end

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  private

  def require_admin!
    current_user.admin || true_user.admin
  end
end

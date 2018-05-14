class UsersController < ApplicationController
  before_action :require_admin! # your authorization method

  def index
    @users = User.order(:id)
  end

  def impersonate
    user = User.find(params[:id])
    authorize user
    impersonate_user(user)
    redirect_to my_composts_path
  end

  def stop_impersonating
    authorize true_user
    stop_impersonating_user
    redirect_to dashboard_path
  end

  private

  def require_admin!
    current_user.admin || true_user.admin
  end
end

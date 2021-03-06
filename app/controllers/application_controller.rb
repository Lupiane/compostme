class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pretender
  impersonates :user

  # Pundit
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :user_composts], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :user_composts, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  # Overriding Rails.application.default_url_options[:host] to generate absolute
  # url for images
  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :photo, :photo_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :photo, :photo_cache])
  end
end



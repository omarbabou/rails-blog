class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def all_users
    User.all.order('id asc')
  end

  def current_post
    User.find(params[:user_id]).posts.find(params[:id] || params[:post_id])
  end

  def all_users_post_controller
    User.find(params[:user_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end
end
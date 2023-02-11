class ApplicationController < ActionController::Base
  include JsonWebToken
  protect_from_forgery with: :exception
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

  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_request

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :password_confirmation, :current_password)
    end
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @curr_user = User.find(decoded[:user_id])
  end
end
    protected
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
        devise_parameter_sanitizer.permit(:sign_in) do |user_params|
          user_params.permit(:username, :email)
      end
    end
  end

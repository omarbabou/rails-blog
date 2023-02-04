class UsersController < ApplicationController
  def index
    @users = all_users
  end

  def show
    @user = current_user
  end
end

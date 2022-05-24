class UsersController < ApplicationController

  def new

  end

  def create
    if user_params.values.include?("") || user_params[:password] != user_params[:password_confirmation]
      flash[:error] = "Missing Credentials"
      redirect_to register_path
    else
      user = user_params
      user[:email] = user[:email].downcase
      new_user = User.create!(user)
      session[:user_id] = new_user.id
      redirect_to "/dashboard"
    end
  end
  
  def show
    if current_user.nil?
      flash[:error] = "Please log in to see dashboard"
      redirect_to "/"
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end

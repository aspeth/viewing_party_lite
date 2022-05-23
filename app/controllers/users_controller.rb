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
      redirect_to "/users/#{new_user.id}/"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def login_form
    
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Incorrect Credentials"
      render :login_form
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end

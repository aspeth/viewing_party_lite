class SessionsController < ApplicationController
    
  def new
    
  end
  
  def create
    user = User.find_by(email: user_params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to "/dashboard"
    else
      flash[:error] = "Incorrect Credentials"
      render :new
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end
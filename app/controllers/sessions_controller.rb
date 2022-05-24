class SessionsController < ApplicationController
    
  def new
    
  end
  
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to "/admin/dashboard"
      elsif user.manager?
        redirect_to "/manager/dashboard"
      elsif user.default?
        redirect_to "/dashboard"
      end
    else
      flash[:error] = "Incorrect Credentials"
      render :new
    end
  end

  def delete
    session.destroy
    redirect_to "/"
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end
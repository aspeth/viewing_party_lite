class Admin::DashboardController < ApplicationController
  def index
    @default_users = User.where(role: 0)
  end

  def show
    User.find(params[:id])
    redirect_to "/"
  end
end
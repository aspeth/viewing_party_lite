class PartiesController < ApplicationController

  def new
    movie_facade = MovieFacade.new
    @users = User.all
    @movie = movie_facade.search_by_id(params[:id])
    if current_user.nil?
      flash[:error] = "Please log in to create parties"
      redirect_to "/movies/#{@movie.id}"
    end
  end

  def create
    party = Party.create!(party_params)
    params[:invite_users].each do |user_id|
      UserParty.create!(user_id: user_id, party_id: party.id) if user_id != ""
    end
    redirect_to "/dashboard"
  end

private

  def party_params
    # params.permit(:id, :user_id, :start_time, :duration, :invite_users)
    {
      host_id: current_user[:id],
      date: params[:start_time],
      duration: params[:duration],
      movie_id: params[:id]
    }
  end
end

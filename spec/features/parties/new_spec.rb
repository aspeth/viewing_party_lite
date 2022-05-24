require 'rails_helper'

RSpec.describe "new viewing party page" do
  before :each do
    @user_1 = User.create!(name: "Twitch", email: "twitch@dogmail.com", password: "password", password_confirmation: "password")

    visit "/"

    click_link "Log In"
    
    fill_in "Email", with: @user_1.email
    fill_in "Password", with: @user_1.password
    fill_in "Password Confirmation", with: @user_1.password_confirmation
    click_button "Log In"
  end

  it "has the name of the movie and form to create new party" do
    json_response = File.read("./spec/fixtures/shawshank.json")
    user_1 = User.create!(name: "Twitch", email: "twitch_4@dogmail.com", password: "password", password_confirmation: "password")
    stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=131d23d3e9d511ff6fce6fdc6799d9be&append_to_response=credits,reviews").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})
    visit "/movies/278/viewing-party/new"

    expect(page).to have_field(:duration)
    expect(page).to have_field(:start_time)
    expect(page).to have_field("invite_users[]")
    expect(page).to have_button("Create Party")
  end

  it "can create new parties" do
    json_response = File.read("./spec/fixtures/shawshank.json")
    # user_1 = User.create!(name: "Twitch", email: "twitch_5@dogmail.com", password: "password", password_confirmation: "password")
    user_2 = User.create!(name: "Carl", email: "carl@catmail.com", password: "password", password_confirmation: "password")
    stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=131d23d3e9d511ff6fce6fdc6799d9be&append_to_response=credits,reviews").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})
    visit "/movies/278/viewing-party/new"

    fill_in :duration, with: 150
    fill_in :start_time, with: "2022-05-13 17:39:57.273645"
    page.check("Twitch")
    page.check("Carl")
    click_button "Create Party"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Save the date: Fri, May 13 2022")
  end
end

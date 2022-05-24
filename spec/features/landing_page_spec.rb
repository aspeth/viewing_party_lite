require 'rails_helper'

RSpec.describe "landing page" do
  it "displays the name of the application" do
    visit '/'

    expect(page).to have_content("Viewing Party Lite")
  end

  it "has a button to create a new user" do
    visit '/'

    expect(page).to_not have_content("Carl")
    expect(page).to have_button("Create New User")

    click_button "Create New User"
    fill_in "Name", with: "Carl"
    fill_in "Email", with: "carl@catmail.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Submit"

    expect(current_path).to match("/dashboard")
    expect(page).to have_content("Carl")
  end

  it "has a link to the landing page" do
    visit '/'

    expect(page).to have_link("Landing Page")
  end

  it "happy path - log in" do
    user_1 = User.create!(name: "Twitch", email: "twitch_2@dogmail.com", password: "password", password_confirmation: "password")
    visit "/"

    click_link "Log In"

    expect(current_path).to eq("/login")

    fill_in "Email", with: user_1.email
    fill_in "Password", with: user_1.password
    fill_in "Password Confirmation", with: user_1.password_confirmation
    click_button "Log In"

    expect(current_path).to eq("/dashboard")
  end

  it "sad path - log in" do
    user_1 = User.create!(name: "Twitch", email: "twitch_3@dogmail.com", password: "password", password_confirmation: "password")
    visit "/"

    click_link "Log In"

    expect(current_path).to eq("/login")

    fill_in "Email", with: user_1.email
    fill_in "Password", with: "Notmypassword"
    fill_in "Password Confirmation", with: "Notmypassword"
    click_button "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Incorrect Credentials")
  end

  it "log in / log out" do
    user_1 = User.create!(name: "Twitch", email: "twitch@dogmail.com", password: "password", password_confirmation: "password")
    visit "/"
    
    click_link "Log In"
    
    expect(current_path).to eq("/login")
    
    fill_in "Email", with: user_1.email
    fill_in "Password", with: user_1.password
    fill_in "Password Confirmation", with: user_1.password_confirmation
    click_button "Log In"
    
    visit "/"

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_link("Log Out")
    
    click_link "Log Out"
    
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
    expect(page).to_not have_link("Log Out")
  end

  it "visitors don't see users" do
    user_1 = User.create!(name: "Twitch", email: "twitch@dogmail.com", password: "password", password_confirmation: "password")
    user_2 = User.create!(name: "Carl", email: "carl@catmail.com", password: "password", password_confirmation: "password")
    visit '/'

    expect(page).to_not have_content("Twitch")
    expect(page).to_not have_content("Carl")
  end
end

require 'rails_helper'

RSpec.describe "admin dashboard" do
  it "has a list of all default users' email addresses that link to their dashboards" do
    user_1 = User.create!(name: "Twitch", email: "twitch@dogmail.com", password: "password", password_confirmation: "password", role: 2)
    user_2 = User.create!(name: "Riley", email: "Riley@dogmail.com", password: "password", password_confirmation: "password")
    user_3 = User.create!(name: "Carl", email: "carl@catmail.com", password: "password", password_confirmation: "password")
    
    visit "/"

    click_link "Log In"
    
    expect(current_path).to eq("/login")
    
    fill_in "Email", with: user_1.email
    fill_in "Password", with: user_1.password
    fill_in "Password Confirmation", with: user_1.password_confirmation
    click_button "Log In"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Riley@dogmail.com")
    expect(page).to have_content("carl@catmail.com")

    click_link "carl@catmail.com"

    expect(current_path).to eq("/admin/users/#{user_3.id}")
  end
end

# When I log in as an admin user
# I'm taken to my admin dashboard `/admin/dashboard`
# I see a list of all default user's email addresses
# When I click on a default user's email address
# I'm taken to the admin users dashboard. `/admin/users/:id`
# Where I see the same dashboard that particular user would see
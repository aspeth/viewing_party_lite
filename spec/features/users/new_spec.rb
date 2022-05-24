require 'rails_helper'

RSpec.describe 'New User Registration Page Features' do

  describe 'registration form' do

    it 'renders a form with a name and email field' do
      visit '/register/'

      expect(page).to have_field(:email)
      expect(page).to have_field(:name)
      expect(page).to have_button("Submit")
    end

    it 'once submitted, takes user to their new profile page' do
      visit '/register/'
      fill_in :email, with: "johndoe@gmail.com"
      fill_in :name, with: "John Doe"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_on "Submit"
      expect(current_path).to eq("/dashboard")
    end

    it 'requires that the email is not already linked to a registered user' do
      visit '/register/'
      fill_in :email, with: "johndoe@gmail.com"
      fill_in :name, with: "John Doe"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_on "Submit"
    end
    
    it "sad path - missing name" do
      visit '/register'
      fill_in :email, with: "johndoe@gmail.com"
      #missing name
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_on "Submit"
      
      expect(current_path).to eq("/register")
      expect(page).to have_content("Missing Credentials")
    end

    it "sad path - missing email" do
      visit '/register'
      #missing email
      fill_in :name, with: "name"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_on "Submit"
      
      expect(current_path).to eq("/register")
      expect(page).to have_content("Missing Credentials")
    end

    it "sad path - passwords don't match" do
      visit '/register'
      fill_in :email, with: "hello@hello.com"
      fill_in :name, with: "name"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "123"
      click_on "Submit"
      
      expect(current_path).to eq("/register")
      expect(page).to have_content("Missing Credentials")
    end
  end

end

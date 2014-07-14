require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
describe "Sign Up page" do

  it "should have the h1 'Sign Up'" do
    visit new_path
    page.should have_content("Sign Up")
  end
   it "should have the h1 'Sign Up'" do
    visit signup_path
    expect(page).to have_title('Demo App | Sign Up' )
  end
end
end

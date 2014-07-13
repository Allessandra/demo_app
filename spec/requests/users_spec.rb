require 'rails_helper'

RSpec.describe "Users", :type => :request do
  describe "Home page" do
  it "should have the h1 'Sign Up'" do
    visit root_path
    page.should have_content("Sign Up")
  end
   it "should have the title 'Sign Up'" do
    visit root_path
    expect(page).to have_title('Demo | Sign Up' )
  end
  end
end

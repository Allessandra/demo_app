require 'rails_helper'

RSpec.describe "Users", :type => :request do
  describe "Sign up page" do
  it "should have the h1 'Sign up'" do
    visit signup_path
    page.should have_content("Sign up")
  end
   it "should have the title 'Sign up'" do
    visit signup_path
    save_and_open_page
    expect(page).to have_title('Demo | Sign up')
  end
  end
end

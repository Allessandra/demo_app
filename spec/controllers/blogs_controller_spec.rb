require 'rails_helper'

RSpec.describe BlogsController, :type => :controller do


describe "Home page" do
  it "should have the h1 'Home'" do
    visit root_path
    page.should have_content("Home")
  end
   it "should have the h1 'Home'" do
    visit root_path
    expect(page).to have_title('Demo App | Home' )
  end
end
  describe "About page" do
  it "should have the h1 'About Us'" do
    visit about_path
    page.should have_content("About Us")
  end
   it "should have the h1 'About Us'" do
    visit about_path
    expect(page).to have_title('Demo App | About Us' )
  end
  
end



end

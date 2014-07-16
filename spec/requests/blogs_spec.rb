require 'rails_helper'

RSpec.describe "Blogs", :type => :request do
describe "Home page" do
  it "should have the h1 'Home'" do
    visit root_path
    page.should have_content("Home")
  end
   it "should have the title 'Demo'" do
    visit root_path
    expect(page).to have_title('Demo' )
  end
end
 describe "About page" do
  it "should have the h1 'About Us'" do
    visit about_path
    page.should have_content("About Us")
  end
   it "should have the title 'Demo | About Us'" do
    visit about_path
    expect(page).to have_title('Demo | About Us' )
  end
end
describe "Contact page" do
  it "should have the h1 'Contact Us'" do
    visit contact_path
    page.should have_content("Contact Us")
  end
  it "should have the title 'Demo | Contact Us'" do
    visit contact_path
    expect(page).to have_title('Demo | Contact Us' )
  end
end
  



end



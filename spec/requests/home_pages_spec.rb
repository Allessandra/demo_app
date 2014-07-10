require 'rails_helper'

describe "App pages" do
  describe "Home page" do
    it "should have the content 'Our Demo App'" do
      visit '/home_page/home'
      puts page.body
      page.should have_content('Our Demo App')
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/home_page/about'
      puts page.body
      page.should have_content('About Us')
    end
  end
  
  describe "Location page" do
    it "should have the content 'Location'" do
      visit '/home_page/location'
      puts page.body
      page.should have_content('Location')
    end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit '/home_page/contact'
      puts page.body
      page.should have_content('Contact Us')
    end
  end
  
end
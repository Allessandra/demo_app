require 'rails_helper'

describe "App pages" do
  describe "Home page" do
    it "should have the content 'Our Demo App'" do
      visit '/home_page/home'
      puts page.body
      page.should have_content('Our Demo App')
    end
    
     it "should have the title" do
       visit '/home_page/home'
       expect(page).to have_title('Demo App|Home')
     end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/home_page/about'
      puts page.body
      page.should have_content('About Us')

    end
    it "should have the right title" do
       visit '/home_page/about'
       expect(page).to have_title('Demo App|About Us')
     end
  end
  
  describe "Location page" do
    it "should have the content 'Location'" do
      visit '/home_page/location'
      puts page.body
      page.should have_content('Location')
    end
     it "should have the right title" do
       visit '/home_page/location'
       expect(page).to have_title('Demo App|Location')
     end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit '/home_page/contact'
      puts page.body
      page.should have_content('Contact Us')
    end
    it "should have the right title" do
       visit '/home_page/contact'
       expect(page).to have_title('Demo App|Contact Us')
     end
  end
  
end
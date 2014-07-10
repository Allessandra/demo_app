require 'rails_helper'

describe "Home pages" do
  describe "Home page" do
  it "should have the content 'Our Demo App'" do
    visit '/home_page/home'
    page.should have_content('Our Demo App')
  end
end
end
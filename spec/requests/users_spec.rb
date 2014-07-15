require 'rails_helper'

RSpec.describe "Users", :type => :request do
  subject {page}
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
  
  describe "profile page" do
    let(:user){FactoryGirl.create(:user)}
    before do
      visit user_path(user)
    end
    it { should have_selector('h1', text: user.name) }
    it { expect(page).to have_title("Demo | #{user.name}")}
    #it { should have_selector('title', text: user.name) }

  end
end

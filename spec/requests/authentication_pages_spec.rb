require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do
  subject {page}
  describe "signin "do
  before {visit root_path}
    describe "with invalid info"do
      before {click_button "Sign in"}
      it {should have_selector('div.alert.alert-danger', text: 'Invalid')}
    end
    describe "with valid info"do
      let(:user){FactoryGirl.create(:user)}
      before do
        fill_in "Email",with:user.email
        fill_in "Password",with:user.password
        click_button"Sign in"
      end
      it { expect(page).to have_title("Demo | #{user.name}")}
      it {should have_link('Profile',href:user_path(user))}
      #it {should have_link{'Users'},href:user_path(user)}
      #it {should have_link{'Settings'},href:user_path(user)}
      it {should_not have_link('Sign in',href:root_path)}
      it {should_not have_link('Sign up',href:signup_path)}
      
    
    end
  end
 
end

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
      # before do
        # fill_in "Email",with:user.email
        # fill_in "Password",with:user.password
        # click_button"Sign in"
      #end
        before{sign_in user}
      
      # it { expect(page).to have_title("Demo | #{user.name}")}
      it {should have_link('Profile',href: user_path(user))}
      #it {should have_link{'Users'},href: user_path(user)}
      it {should have_link('Settings',href: edit_user_path(user))}
      it {should_not have_content('Sign in')}
      #it {should_not have_link('Sign in', href: root_path)}
      it {should_not have_selector('a', text: 'Sign in')}
      it {should_not have_link('Sign Up',href: signup_path)}
      
      describe "followed by signout"do
        before do
          click_link "Sign out"
        end
        it {should have_button('Sign in')}
      end
    end
  end
 describe "authorization"do
  describe "for non-signed users"do
    let(:user){FactoryGirl.create(:user)}
    describe "in the users controller"do
      before {visit edit_user_path(user)}
      it { expect(page).to have_title("Demo")}
      it {should have_selector('div.alert.alert-success')}
    end
  end
 end
end

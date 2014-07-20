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
    
    describe"When attemping to visit a protected page"do
      before do
        visit edit_user_path(user)
        fill_in "Name", with:user.name
        fill_in "Email", with:user.email
        click_button "Sign in"
      end
      describe "after signing in"do
        it "should render the desired protected page"do
        it { expect(page).to have_title("Demo | Edit User")}

      end
    end
    
    describe "in the users controller"do
      before {visit edit_user_path(user)}
      it { expect(page).to have_title("Demo")}
      it {should have_selector('div.alert.alert-success')}
    end
  describe"submitting to the update action"do
    before{put user_path(user)}
    specify {response.should redirect_to(root_path)}
  end
  describe"as wrong user"do
    let(:user){FactoryGirl.create(:user)}
    let(:wrong_user){FactoryGirl.create(:user, email:"wrong@example.com")}
    before{sign_in}
    describe "visiting users#edit page"do
      before{visit edit_user_path(wrong_user)}
      it{should_not have_selector('title',text:'Edit user') }
      #it { expect_not(page).to have_title("Demo")}
    end
    describe "submitting a PUT request to the User#update action"do
     before{put user_path(wrong_user) }
     specify{response.should redirect_to(root_path)}
    end
  end
 end
end
end

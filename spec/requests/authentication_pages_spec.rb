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
      
        it { expect(page).to have_title("Demo | #{user.name}")}
        it {should have_link('Profile',href: user_path(user))}
        it {should have_link('Users',href: users_path)}
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
        fill_in "Email", with:user.email
        fill_in "Password", with:user.password
        click_button "Sign in"
      end
      describe "after signing in"do
        it "should render the desired protected page" do
          expect(page).to have_title("Demo | Edit User")
        end
      end
      describe "when sign in again"do
        before do
          click_link "Sign out"
          sign_in user
        end
        it "should render to default page"do
          expect(page).to have_title("Demo | #{user.name}")
        end
       end
      end
      
    describe "in the users controller"do
    
      describe"visiting the edit page"do
        before {visit edit_user_path(user)}
        it { expect(page).to have_title("Demo")}
        it {should have_selector('div.alert.alert-success')}
      end
      
      describe"submitting to the update action"do
        before{put user_path(user)}
        it{expect(response).to redirect_to(root_path)}
        #specify {response.should redirect_to(root_path)}
      end
      describe"visiting the user index"do
        before{visit users_path}
        it { expect(page).to have_title("Demo")}
      end
      
      describe"visiting the following page" do
        before{visit following_user_path(user) }
        it { expect(page).to have_title("Demo")}
      end
      describe"visiting the followers page" do
        before{visit followers_path(user) }
        it { expect(page).to have_title("Demo")}
      end
    end
   end
   describe"in the posts controller"do
    describe "submitting to the create action"do
      before{post posts_path}
      specify{response.should redirect_to(root_path)}
    end
    describe"submitting to destroy action"do
      before{delete post_path(FactoryGirl.create(:post))}
      specify{response.should redirect_to(root_path)}
    end
   end
  end
  
  describe"in the relationships controller" do
    describe "submitting to the create action"do
      before{post relationships_path}
      specify{response.should redirect_to(root_path)}
    end
    describe"submitting to destroy action"do
      before{delete relationship_path(1)}
      specify{response.should redirect_to(root_path)}
    end
  end
  
  describe"as wrong user"do
    let(:user){FactoryGirl.create(:user)}
    let(:wrong_user){FactoryGirl.create(:user, email:"wrong@example.com")}
    before{sign_in(user)}
    describe "visiting users#edit page"do
      before{visit edit_user_path(wrong_user)}
      #it{should_not have_selector('title',text:'Edit user') }
      it { expect(page).to have_no_title("Demo | Edit user")}
    end
    describe "submitting a PUT request to the User#update action"do
     before{put user_path(wrong_user) }
     specify{response.should redirect_to(root_path)}
    end
  end
 end
 
 describe "as non-admin user"do
  let(:user){FactoryGirl.create(:user)}
  let(:non_admin){FactoryGirl.create(:user)}
  before {sign_in non_admin}
  describe"submit a delete request to Users#destroy action"do
    before {delete user_path(user)}
    specify{response.should redirect_to(root_path)}
  end
 end



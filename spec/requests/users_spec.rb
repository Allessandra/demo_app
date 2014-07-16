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
  describe "sign up"do
    before{visit signup_path}
    let(:submit){"Create my account"}
    
    describe"with invalid info"do
      it "shouldn't create user"do
        expect{click_button submit}.not_to change(User, :count)
        
        #old_count=User.count
        #click_button submit
        #new_count=User.count
        #new_count.should==old_count
      end
    end
    describe"with valid info"do
      before do
        within("form#new_user") do
      fill_in "Name",with:"Example user"
      fill_in "Email",with:"user@example.com"
      fill_in "Password",with:"foobarbaz"
      fill_in "Confirmation",with:"foobarbaz"
      end
      end
      it "should create user"do
      expect{click_button submit}.to change(User,:count).by(1)
      end
      #old_count=User.count
      #it "should create user"do
      #fill_in "Name",with:"Example user"
      #fill_in "Email",with:"user@example.com"
      #fill_in "Password",with:"foobar"
      #fill_in "Password_confirmation",with:"foobar"
      #click_button submit
      #new_count=User.count
      #new_count.should==old_count+1
      #end
      describe"after saving a user"do
        before{click_button submit}
        let(:user){User.find_by_email("user@example.com")}
        it { expect(page).to have_title("Demo | #{user.name}")}
      end
    end
  end
  
end

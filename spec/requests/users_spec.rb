require 'rails_helper'

RSpec.describe "Users", :type => :request do
  subject {page}
  
  describe"index"do
    let(:user){FactoryGirl.create(:user)}
    before(:all){30.times{FactoryGirl.create(:user)}}
    after(:all){User.delete_all}
    before(:each)do
      sign_in user
      # sign_in FactoryGirl.create(:user)
      # FactoryGirl.create(:user, name:"Bob",email:"bob@example.com")
      # FactoryGirl.create(:user, name:"Ben",email:"ben@example.com")
      visit users_path
    end
    it {should have_selector('h1', text: "All Users") }
    it {expect(page).to have_title("Demo | All Users")}
    
    describe "pagination"do
      it {should have_selector('div.pagination')}
      it "should list each user"do
        #User.all.each do |user|
        User.paginate(page: 1).each do |user|
          page.should have_selector('li>a',text:user.name)
        end
      end
     describe "delete links"do
        it {should_not have_link('delete')}
        describe "as an admin"do
            let(:admin){FactoryGirl.create(:admin)}
            before do
              sign_in admin
              visit users_path
            end
            it {should have_link('delete', href: user_path(User.first))}
            it "should be able to delete another users"do
              expect{click_link('delete')}.to change(User, :count).by(-1)
            end
            it{should_not have_link('delete',href:user_path(admin))}
         end
      end
    end
    
    
    
    
  end 
   
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
      end
      
      describe"after saving a user"do
        before do 
          click_button submit
          puts page.body
        end
        let(:user){User.find_by_email("user@example.com")}
        it { expect(page).to have_title("Demo | #{user.name}")}
        it {should have_link('Sign out')}
        it {should have_selector('div.alert.alert-success')}
      end
    end
  end
  describe "edit" do
    let(:user){FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end
    describe "page"do
      it { should have_selector('h1', text: "Update your profile") }
      it { expect(page).to have_title("Demo | Edit User")}
      it {should have_link('change', href:'http://gravatar.com/emails')}
    end
    describe"with invalid info"do
      before{click_button "Save changes"}
      it {should have_content('error')}
    end
    describe "with valid info"do
    let(:new_name){"New Name"}
    let(:new_email){"new@example.com"}
    before do
      within("form.edit_user") do
      fill_in "Name" , with: new_name
      fill_in "Email", with: new_email
      fill_in "Password", with: user.password
      fill_in "Confirm Password", with: user.password
      click_button "Save changes"
      #puts "-------------", page.body
      end
    end
    it { expect(page).to have_title("Demo | #{new_name}")}
    it {should have_link('Sign out'),href: signout_path}
    it {should have_selector('div.alert.alert-success')}
    specify {user.reload.name.should==new_name} #-> it {should user.name == new_name}
    specify {user.reload.email.should==new_email}

   end
  end
    
end

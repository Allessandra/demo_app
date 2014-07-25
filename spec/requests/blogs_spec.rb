require 'rails_helper'

RSpec.describe "Blogs", :type => :request do
describe "Home page" do
  before{visit root_path}
  
  it "should have the h1 'Home'" do
    page.should have_content("Home")
  end
  it "should have the title 'Demo'" do
    expect(page).to have_title('Demo' )
  end
  describe"for signed-in users"do
    let(:user){FactoryGirl.create(:user)}
    before do
      FactoryGirl.create(:post,user:user,title:"test",content:"loren ipsum")
      FactoryGirl.create(:post,user:user,title:"test2",content:"loren Daltex")
      sign_in user
      visit root_path
    end
    it "should render the user's feed"do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}",text: item.title)
        page.should have_selector("li##{item.id}",text: item.content)
      end
    end
    describe "follower/following count" do
      let(:other_user){FactoryGirl.create(:user)}
      before do
        other_user.follow!(user)
        visit root_path
      end
      it {should have_link("0 following",href: following_user_path)}
      it {should have_link("1 followers",href: followers_user_path)}
    end
  end
end
 describe "About page" do
  it "should have the h1 'About Us'" do
    visit about_path
    page.should have_content("About Us")
  end
   it "should have the title 'Demo | About Us'" do
    visit about_path
    expect(page).to have_title('Demo | About Us' )
  end
end
describe "Contact page" do
  it "should have the h1 'Contact Us'" do
    visit contact_path
    page.should have_content("Contact Us")
  end
  it "should have the title 'Demo | Contact Us'" do
    visit contact_path
    expect(page).to have_title('Demo | Contact Us' )
  end
end
  



end



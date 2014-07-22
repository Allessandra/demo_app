require 'rails_helper'

RSpec.describe "PostPages", :type => :request do

  subject {page}
  let(:user){FactoryGirl.create(:user)}
  
  before{sign_in user}
  
  describe"post creation"do
    before{visit root_path}
    describe"with invalid info"do
      it "shouldn't create post"do
        expect{clicl_button "Post"}.not_to change(Post,:count)
      end
      describe"error messages"do
        before{click_button"Post"}
        it{should have_content('error')}
      end
    end
  end
  
  describe"post destruction"do
    before{FactoryGirl.create(:post,user:user)}
    describe"as corrected user"do
      before{visit root_path}
      it "should delete a post "do
        expect{click_link "delete"}.should change(Post,:count).by(-1)
      end
    end
  
  end
  

end

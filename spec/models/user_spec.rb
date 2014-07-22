require 'rails_helper'

RSpec.describe User, :type => :model do
it "should be a test"
before { @user=User.new(name: "alex" ,
   email: "alex@example.com" ,
   password:"testtest",password_confirmation:"testtest")}
subject {@user}
it {should respond_to(:name)}
it {should respond_to(:email)}
it {should respond_to(:password_digest)}
it {should respond_to(:password)}
it {should respond_to(:password_confirmation)}
it {should respond_to(:authenticate)}
it {should respond_to(:remember_token)}
it {should respond_to(:admin)}
it {should respond_to(:posts)}
it {should respond_to(:feed)}

it {should be_valid}
it {should_not be_admin}

# describe "accessible attributes"do
  # it "should not allow access to admin"do
    # expect do
      # User.new(admin: "1")
    # end
  # end
#end


describe "when name is not present" do
  before {@user.name=" "}
  it {should_not be_valid}
end
describe "when email in not present" do
  before {@user.email=" "}
  it {should_not be_valid}
end

describe "when name is too long" do
  before{ @user.name="a" * 41}
  it {should_not be_valid}
end

describe "when email format is not valid" do
  it "should be not valid" do
    addresses= %w[user@foo,com user_at.org user.ex@foo. foo@bar_vaz.com]
    addresses.each do|invalid_add|
      @user.email=invalid_add
      @user.should_not be_valid
    end
  end
end

describe "when email format is valid" do
  it "should be valid" do
    addresses= %w[user@foo.COM USER_at-hg@b.o.org us_er+ex@fo.com]
    addresses.each do|valid_add|
      @user.email=valid_add
      @user.should be_valid
    end
  end
end

describe "when email address is already taken" do
  before do
    user_with_same_add=@user.dup
    user_with_same_add.email=@user.email.upcase
    user_with_same_add.save
  end
  it {should_not be_valid}
end
describe "when password is not present" do
  before{@user.password=@user.password_confirmation=" "}
  it {should_not be_valid}
end

describe "when password doesn't match confirmation" do
  before{@user.password_confirmation="mismatch"}
  it {should_not be_valid}
end

describe "when confirmation is nil" do
  before{@user.password_confirmation=nil}
  it{should_not be_valid}
end

describe "when password in too short" do
  before{@user.password=@user.password_confirmation="a"*5}
  it {should_not be_valid}
end

describe"return value of authenticate method" do
  before {@user.save}
  let(:found_user){User.find_by_email(@user.email)}
  describe "with valid password" do
    it{should == found_user.authenticate(@user.password)}
  end
  describe "with invalid password" do
    let(:user_for_invalid_password){found_user.authenticate("invalid")}
    it {should_not == user_for_invalid_password}
    specify { expect(user_for_invalid_password).to be_falsey}
  end
end

describe "remember token"do
  before {@user.save}
  #its(:remember_token){ should_not be_blank}
  it "should have a nonblank remember token" do
    subject.remember_token.should_not be_blank
    #subject->@user  
  end
end

describe "post associations"do
  before{@user.save}
  let!(:older_post)do
    FactoryGirl.create(:post, user:@user,created_at: 1.day.ago)
  end
  let!(:newer_post)do
    FactoryGirl.create(:post, user:@user, created_at: 1.hour.ago)
  end
  it "should have the right post in the right order" do
    @user.posts.should==[newer_post,older_post]
  end
  it "should destroy associated posts"do
    posts=@user.posts
    @user.destroy
    posts.each do |post|
      Post.find_by_id(post.id).should be_nil
    end
  end
  describe "status"do
    let(:unfollowed_post)do
      FactoryGirl.create(:post,user: FactoryGirl.create(:user))
    end
    its(:feed){should include(older_micropost)}
    its(:feed){should include(newer_micropost)}
    its(:feed){should_not include(unfollowed_post)}
  end
end



end
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

it {should be_valid}

describe "when name in not present" do
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
    addresses= %w[user@foo,com user_at.org user.ex@foo.]
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
    it{should==found_user.authenticate(@user.password)}
  end
  describe "with invalid password" do
    it{should_not==found_user.authenticate("invalid")}
    specify{found_user.authenticate("invalid").should be_false}
  end
end




end
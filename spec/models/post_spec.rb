require 'rails_helper'

RSpec.describe Post, :type => :model do

let(:user){FactoryGirl.create(:user)}
before do
  #@post= Post.new(title:"test",content:"loren ipsum",user_id:user.id)
  @post= user.posts.build(title:"test",content:"loren ipsum")
end

subject{@post}

it {should respond_to(:title)}
it {should respond_to(:content)}
it {should respond_to(:user_id)}
it {should respond_to(:user)} #due to relation
its(:user) {should==user}

it {should be_valid}
describe "when user_id isn't present"do
  before{@post.user_id=nil}
  it {should_not be_valid}
end

describe "with blank title" do
  before {post.title=" "}
  it {should_not be_valid}
end

describe "with title that is too long"do
  before{@post.title="a"*20}
  it{should_not be_valid}
end

describe "with blank content" do
  before {post.content=" "}
  it {should_not be_valid}
end
end

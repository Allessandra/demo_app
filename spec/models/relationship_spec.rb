require 'rails_helper'

RSpec.describe Relationship, :type => :model do

let(:follower){FactoryGirl.create(:user)}
let(:followed){FactoryGirl.create(:user)}
let(:relationship){follower.relationship.build(followed_id:followed.id)}

subject{relationship}

describe"follower method" do
  it {should respond_to(:followed)}
  it {should respond_to(:follower)}
  its(:follower){should==follower}
  its(:followed){should==followed}
end

describe "when followed id isn't present" do
  before{relationship.followed_id =nil}
  it {should_not be_valid}
end
describe "when follower id isn't present" do
  before{relationship.follower_id =nil}
  it {should_not be_valid}
end





end

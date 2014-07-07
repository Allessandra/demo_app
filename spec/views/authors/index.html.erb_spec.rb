require 'rails_helper'

RSpec.describe "authors/index", :type => :view do
  before(:each) do
    assign(:authors, [
      Author.create!(
        :name => "Name",
        :date_of_birth => "Date Of Birth"
      ),
      Author.create!(
        :name => "Name",
        :date_of_birth => "Date Of Birth"
      )
    ])
  end

  it "renders a list of authors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Date Of Birth".to_s, :count => 2
  end
end

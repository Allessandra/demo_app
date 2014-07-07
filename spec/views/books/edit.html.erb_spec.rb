require 'rails_helper'

RSpec.describe "books/edit", :type => :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :name => "MyString",
      :library_id => 1,
      :author_id => 1
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input#book_name[name=?]", "book[name]"

      assert_select "input#book_library_id[name=?]", "book[library_id]"

      assert_select "input#book_author_id[name=?]", "book[author_id]"
    end
  end
end

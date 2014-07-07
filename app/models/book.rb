class Book < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :library
  belongs_to :author
end

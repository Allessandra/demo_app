class Author < ActiveRecord::Base
  validates :name, :presence => true
  validates :date_of_birth, :presence => true
  has_many :books
end

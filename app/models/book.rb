class Book < ActiveRecord::Base
  validates :name, :presence => true
  validates :library_id, :presence => true
  validates :author_id, :presence => true

  belongs_to :library
  belongs_to :author
end

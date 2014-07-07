class Book < ActiveRecord::Base
  validates :name, :presence => true
  validates :library_id, :presence => true
  va1lidates :author_id, :presence => true

  belongs_to :library
  belongs_to :author
end

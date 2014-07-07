class Library < ActiveRecord::Base
  validates :name, :presence => true
  validates :url, :presence => true
  has_many :books

end

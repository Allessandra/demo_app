class Post < ActiveRecord::Base

belongs_to :user #many relation
validates :user_id, presence: true
validates :title , presence: true, length: {maximum:19}
validates :content ,presence: true

default_scope order:'posts.created_at DESC'
#as default older 1st




end

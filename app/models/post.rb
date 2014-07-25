class Post < ActiveRecord::Base

belongs_to :user #many relation
validates :user_id, presence: true
validates :title , presence: true, length: {maximum:19}
validates :content ,presence: true

default_scope { order('created_at DESC') }
#as default older 1st

def self.from_users_followed_by(user)
  #followed_ids=user.followed_users.map(&:id)
  #followed_ids=user.followed_user_ids
  followed_ids="SELECT followed_id FROM relationships
  WHERE follower_id= :user_id"
  where("user_id IN (#{followed_user_ids}) OR user_id= :user_id",
      {user_id: user.id})  
end


end

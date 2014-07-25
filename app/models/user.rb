class User < ActiveRecord::Base
has_secure_password
has_many :posts ,dependent: :destroy
has_many :relationships, foreign_key: "follower_id",dependent: :destroy
#to make relationship deleted when user is deleted
has_many :followed_users ,through: :relationships,source: :followed

has_many :reverse_relationships, foreign_key: "followed_id",
class_name:"Relationship",dependent: :destroy
has_many :followers ,through: :reverse_relationships,source: :follower

before_save{|user| user.email=user.email.downcase}
#before_save{|user| user.remember_token="hhh"}
before_save :create_remember_token #as when we 
#update and save it creates another token
#so the sign in appears


before_validation do |user| 
  o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten 
  string = (0...4).map { o[rand(o.length)] }.join
  user.name=string if user.name.blank?
end

validates :name, presence: true, length:{maximum: 40}
VAILD_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true,
format: { with: VAILD_EMAIL_REGEX},
uniqueness: {case_sensitive: false}
validates :password, presence: true ,length:{minimum:8}
validates :password_confirmation, presence:true


def following?(other_user)
  self.relationships.find_by_followed_id(other_user.id)
end

def follow!(other_user)
  self.relationships.create!(followed_id: other_user.id)
  #create : raise exception if there's error
end

def unfollow!(other_user)
  self.relationships.find_by_followed_id(other_user.id).destroy
end

def self.name_longer_than_eight
  #u_l = []
  #User.all.each{|u| u_l.push(u) if u.name.length >= 8}
  #puts u_l.inspect
  User.where("length(name) > 8")
end

def feed
  #Post.where("user_id=?",id)
  Post.from_users_followed_by(self)
end

private 
def create_remember_token
  self.remember_token=SecureRandom.urlsafe_base64
  #unique string
  
end
end

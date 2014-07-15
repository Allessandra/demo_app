class User < ActiveRecord::Base
has_secure_password
before_save{|user| user.email=user.email.downcase}
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
validates :password, presence: true ,length:{minimum:6}
validates :password_confirmation, presence:true

def self.name_longer_than_eight
  #u_l = []
  #User.all.each{|u| u_l.push(u) if u.name.length >= 8}
  #puts u_l.inspect
  
  User.where("length(name) > 8")
end

end

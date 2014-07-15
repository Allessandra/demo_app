class User < ActiveRecord::Base
has_secure_password
before_save{|user| user.email=user.email.downcase}

validates :name, presence: true, length:{maximum: 40}
VAILD_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true,
format: { with: VAILD_EMAIL_REGEX},
uniqueness: {case_sensitive: false}
validates :password, presence: true ,length:{minimum:6}
validates :password_confirmation, presence:true
end

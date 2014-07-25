namespace :db do
  desc "fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
 end
end

 def make_users
   admin=User.create!(name:"example user",
    email: "example@hotmail.com",
    password: "foobarbaz",
    password_confirmation: "foobarbaz")
    admin.toggle!(:admin) #to make it true
    99.times do |n|
      name= Faker::Name.name
      email="example-#{n+1}@hotmail.com"
      password="password"
      User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password)
    end
 end
 
 def make_posts
  users=User.limit(6)
  50.times do
    title=Faker::Lorem.word
    content=Faker::Lorem.sentence(8)
    users.each{|user| user.posts.create!(content: content, title: title)}
  end
 end
 
 def make_relationships
   users = User.all
   user = users.first
   followed_users = users[2..50]
   followers = users[3..40]
   followed_users.each{|followed| user.follow!(followed)}
   followers.each {|follower|follower.follow!(user) }
 end
 


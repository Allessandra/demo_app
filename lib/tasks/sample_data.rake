namespace :db do
  desc "fill database with sample data"
  task populate: :environment do
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
  
  users=User.all(limit:6)
  50.times do
    title=Faker::Loren.sentence(1)
    content=Faker::Loren.sentence(5)
    users.each{|user| user.posts.create!(content: content)}
  end
 end
end
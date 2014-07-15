# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Allessandra"
    email "allessandra@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end

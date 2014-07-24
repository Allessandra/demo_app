# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "test"
    content "lorem ipsum"
    user
  end
end

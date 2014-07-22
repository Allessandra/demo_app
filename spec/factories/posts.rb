# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "test"
    content "loren ipsum"
    user
  end
end

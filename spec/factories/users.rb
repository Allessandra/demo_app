# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "Person #{n}"}
    sequence(:email){|n| "person_#{n}@example.com"}
    #name "Allessandra"
    #email "allessandra@gmail.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
    
    factory :admin do
      admin true
    end
  end
  
end

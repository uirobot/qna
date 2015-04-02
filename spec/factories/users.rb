FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@mail.com"
  end

  factory :user do
    email
    password 'qwerty12345'
    password_confirmation 'qwerty12345'
  end
end

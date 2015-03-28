FactoryGirl.define do
  factory :answer do
    sequence(:body) { ('a'..'z').to_a.shuffle.join }
    question nil
  end
end

FactoryGirl.define do

  factory :answer do
    body ('a'..'z').to_a.shuffle.join
    question nil
  end
end

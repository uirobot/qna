FactoryGirl.define do
  factory :question do
    sequence(:title) { ('a'..'z').to_a.shuffle.join }
    body 'MyText'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end

require_relative 'feature_helper'

feature 'Any user can see list of answers', %q{'
  In order to find answer,
  Any User
  can see list of answers inside question'} do
  given!(:question) { create(:question) }
  given!(:answers_list) { create_list(:answer, 3, question: question) }

  scenario 'User go to question page and see answers list' do
    visit question_path(question)
    answers_list.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end
end

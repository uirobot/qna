require 'rails_helper'

feature 'Any user can see list of answers', %q{'
  In order to find answer,
  Any User
  can see list of answers inside question'} do

  given(:question) { create(:question) }
  given(:answers_list) { create_list(:answer, 3, question: question) }

  scenario 'User go to question page and see answers list' do

    visit question_path(question)
    answers_list.size.times do |i|
      expect(page).to have_content answers_list[i].body
    end
  end

end

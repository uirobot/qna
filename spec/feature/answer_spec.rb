require 'rails_helper'

feature 'User can post and see list of answers on question page', %q{'In order to find question answer, User can see list of answers on question page'} do

  given(:question) { create(:question) }

  scenario 'User go to question and post answer' do
    answer = create(:answer)
    visit question_path(question)
    click_on 'Post answer'
    fill_in 'Body', with: answer.body
    click_on 'Send answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
  end

  scenario 'User go to question page and see answers list' do
    questions_list = create_list(:answer, 3, question: question)
    visit question_path(question)
    questions_list.size.times do |i|
      expect(page).to have_content questions_list[i].body
    end
  end

end

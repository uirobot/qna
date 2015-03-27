require 'rails_helper'

feature 'Authenticate User can delete answers', %q{'
  In order to remove answers,
  Authenticated User
  can delete own answers'} do


  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:user_answer) { create(:answer, question: question, user: user)}
  given(:user_answer2) { create(:answer, question: question, user: user2)}

  scenario 'User can delete answers' do
    log_in(user)
    user_answer
    visit question_path(question)
    click_on 'delete answer'
    expect(current_path).to eq question_path(question)
    expect(page).not_to have_content user_answer.body
  end

  scenario 'User can delete only own answers' do
    log_in(user)
    user_answer2
    visit question_path(question)
    expect(page).not_to have_content 'delete answer'
  end

end

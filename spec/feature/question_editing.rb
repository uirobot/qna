require_relative 'feature_helper'
feature 'User can edit own questions', %q{'
  In order to fix mistakes,
  User
  can edit own questions'} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:user_question) { create(:question, user: user) }
  given(:user2_question) { create(:question, user: user2) }


  scenario 'User see edit question button near own questions' do
    log_in(user)
    user_question
    visit questions_path
    expect(page).to have_content 'edit question'
  end

  scenario 'User see question edit button only on own question' do
    user2_question
    log_in(user)
    expect(page).not_to have_content 'edit question'
  end

  scenario 'User can change own question title and body' do
    log_in(user)
    user_question
    visit questions_path
    click_on 'edit question'
    fill_in 'Title', with: 'new title'
    fill_in 'Body', with: 'new body'
    click_on 'Edit question'
    expect(page).to have_content 'new title'
    expect(page).to have_content 'new body'
    expect(current_path).to eq question_path(user_question)
  end

  scenario 'User cannot edit question of different user'
end

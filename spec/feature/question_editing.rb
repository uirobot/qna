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

  scenario 'User didnt see question edit button' do
    user2_question
    log_in(user)
    expect(page).not_to have_content 'edit question'
  end

  scenario 'User c edit question button near own questions' do
    log_in(user)
  end

  scenario 'User can change own question title and body'

  scenario 'User cannot edit question of different user'
end

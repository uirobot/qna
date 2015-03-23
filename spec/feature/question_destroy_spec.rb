require 'rails_helper'

feature 'Authenticate User can delete question', %q{'
  In order to remove question,
  Authenticated User
  can delete own question'} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: user2) }

  scenario 'User can delete question' do
    user
    log_in(user)
    question
    visit questions_path
    click_on 'delete question'
    expect(current_path).to eq questions_path
    expect(page).not_to have_content question.title
  end

  scenario 'User can delete only own question' do
    user
    log_in(user)
    question2
    visit questions_path
    expect(page).not_to have_content 'delete question'
  end

end

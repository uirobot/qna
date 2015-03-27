require 'rails_helper'

feature 'Authenticate  User can create question', %q{'
  In order to find question,
  User
  can create question and see list of all question'} do

  given(:question) { create(:question) }

  scenario 'Authenticate user can create question' do
    user = create(:user)
    log_in(user)
    visit new_question_path
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Send question'
    expect(page).to have_content 'Your question created'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Non authenticate user cant create question' do
    visit questions_path
    click_on 'New Question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end

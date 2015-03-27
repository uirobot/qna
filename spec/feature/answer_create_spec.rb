require 'rails_helper'

feature 'Authenticate User can post answers on question page', %q{'
  In order to post answer,
  Authenticated User
  can post answer'} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }
  given(:answer) { create(:answer) }
  

  scenario 'User go to question and post answer' do

    log_in(user)


    visit question_path(question)
    click_on 'Post answer'
    fill_in 'Body', with: answer.body
    click_on 'Send answer'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
  end

  scenario 'Non authenticated user cant post answer' do
    visit question_path(question)
    click_on 'Post answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end


end

require 'rails_helper'

feature 'User can create question and see questions list', %q{'
  In order to find question,
  User
  can create question and see list of all question'} do

  given(:question) { create(:question) }

  scenario 'User can create question' do
    visit new_question_path
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Send question'
    expect(page).to have_content 'Your question created'
    expect(page).to have_content question.title
  end

  scenario 'User see list of last questions on index page' do
    questions_list = create_list(:question, 3)
    visit questions_path
    questions_list.each do |ques|
      expect(page).to have_content ques[:title]
    end

  end
end

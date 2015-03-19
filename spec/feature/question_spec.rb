require 'rails_helper'

feature 'User can create question', 'In order to get answer, User can create question' do


  scenario 'User can create question' do
    question = create(:question)
    visit new_question_path
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Send question'
    expect(page).to have_content 'Your question created'
  end
end

feature 'User can see questions list', 'In order to find question, User can see list of all question' do
  scenario 'User see list of last questions on index page' do
    questions_list = create_list(:question, 3)
    visit questions_path
    questions_list.each do |ques|
      expect(page).to have_content ques[:title]
    end

  end
end

feature 'User can post answer', 'In order to answer the question, User can post question answer' do
  scenario 'User go to question and post answer' do
    question = create(:question)
    answer = create(:answer)
    visit question_path(question)
    click_on 'Post answer'
    fill_in 'Body', with: answer.body
    click_on 'Send answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
  end
end

feature 'User can see list of answers on question page', 'In order to find question answer, User can see list of answers on question page' do
  scenario 'User go to question page and see answers list'
end

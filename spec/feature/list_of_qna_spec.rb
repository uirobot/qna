require 'rails_helper'

feature 'Any user can see list of questions and answers', %q{'
  In order to find question and answers,
  Any User
  can see list of questions and answers inside'} do

  given(:question) { create(:question) }

  scenario 'User see list of last questions on index page' do
    questions_list = create_list(:question, 3)
    visit questions_path
    questions_list.each do |ques|
      expect(page).to have_content ques[:title]
    end
  end

  scenario 'User go to question page and see answers list' do
    questions_list = create_list(:answer, 3, question: question)
    visit question_path(question)
    questions_list.size.times do |i|
      expect(page).to have_content questions_list[i].body
    end
  end
  
end

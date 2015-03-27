require 'rails_helper'

feature 'Any user can see list of questions', %q{'
  In order to find question,
  Any User
  can see list of questions'} do

  given(:question) { create(:question) }
  given(:questions_list) { create_list(:question, 3) }

  scenario 'User see list of last questions on index page' do
    visit questions_path
    questions_list.each do |ques|
      expect(page).to have_content ques[:title]
    end
  end

end

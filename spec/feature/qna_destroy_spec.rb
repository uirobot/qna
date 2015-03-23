require 'rails_helper'

feature 'Authenticate User can post answers on question page', %q{'
  In order to post answer,
  Authenticated User
  can post answer'} do

  given(:question) { create(:question) }
  given(:user_answer) { create(:answer, question: question)}

  scenario 'User can delete answers' do
    user = create(:user)
    log_in(user)

    visit question_path(question)
    click_on 'delete answer'

    expect(current_path).to eq question_path(question)
    expect(page).not_to have_content answer.body
  end

  scenario 'User can delete only own answers'

end

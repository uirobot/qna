require_relative 'feature_helper'

feature 'Authenticate User can edit own answers on question page', %q{('
  In order to fix mistakes,
  Authenticated User
  can edit own answers')} do
  given(:question) { create(:question) }
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:answer2) { create(:answer, question: question, user: user2) }

  scenario 'User see edit button only below own answers' do
    log_in(user)
    visit question_path(question)
    within(:css, "li#answr_#{answer.id}") do
      expect(page).to have_content "edit answer"
    end
    within(:css, "li#answr_#{answer2.id}") do
      expect(page).not_to have_content "edit answer"
    end
  end

  scenario 'User press on edit button and see form for editing', js: true do
    log_in(user)
    visit question_path(question)
    expect(page).not_to have_selector('input[type=input]')
    within(:css, "li#answr_#{answer.id}") do
      click_on "edit answer"
      expect(page).to have_selector('input[type=text]')
    end
  end

  scenario 'User can edit own answer', js: true do
    log_in(user)
    visit question_path(question)
    click_on "edit answer"
    within(:css, "li#answr_#{answer.id}") do
      find('.inline-edit-form').set('my new answer')
      click_on 'Изменить'
      expect(page).to have_content('my new answer')
    end
  end
end

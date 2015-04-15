require_relative 'feature_helper'

feature 'Question author can mark correct answer', %q{('
  In order to set correct answer,
  Question answer
  can mark answer as correct')} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user ) }
  given(:question2) { create(:question, user: user2 ) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:answer2) { create(:answer, user: user2, question: question2) }
  given!(:answer3) { create(:answer, user: user2, question: question) }

  scenario 'Question author see correct button' do
    log_in(user)
    visit question_path(question)
    within(:css, "li#answr_#{answer.id}") do
      expect(page).to have_content "correct answer"
    end
  end

  scenario 'Only question author see correct button' do
    log_in(user)
    visit question_path(question2)
    within(:css, "li#answr_#{answer2.id}") do
      expect(page).not_to have_content "correct answer "
    end
  end

  scenario 'Question author pressed correct buttons and set correct answer' do
    log_in(user)
    visit question_path(question)
    within "li#answr_#{answer.id}" do
      click_on "correct answer"
    end
    expect(page).to have_content('ANSWER')
  end

  scenario 'Best answers goes first' do
    log_in(user)
    visit question_path(question)
    within ".answer-item:last-child" do
      expect(page).to have_content answer3.body
      click_on "correct answer"
    end
    within ".answer-item:first-child" do
      expect(page).to have_content answer3.body
    end
  end

end

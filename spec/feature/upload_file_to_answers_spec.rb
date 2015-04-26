require_relative 'feature_helper'

feature 'Add files to answer', %q{
  In order to share file in answer
  Answer author
  Can attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    log_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when post answer', js: true do
    fill_in 'Body', with: 'its a answer body'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Send answer'
    within '.answers-list' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
end

require_relative 'feature_helper'

feature 'Delete files from answer', %q{
  In order to delete files in answer
  Answer author
  Can destroy files
} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }
  given(:user2) { create(:user) }

  background do
    log_in(user)
  end

  scenario 'File can delete only author', js: true do
    visit question_path(question)
    fill_in 'Body', with: 'its my answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Send answer'
  end

  scenario 'Not author can delete question files' do
  end

end

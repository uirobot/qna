require_relative 'feature_helper'

feature 'Delete files from question', %q{
  In order to delete files in question
  Question author
  Can destroy files
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }

  background do
    log_in(user)
    visit new_question_path
    fill_in 'Title', with: 'its a title'
    fill_in 'Body', with: 'this is question body'
    attach_files
    click_on 'Send question'
  end

  scenario 'File can delete only author' do
    within '.file-item' do
      click_on 'delete file'
    end
    expect(page).not_to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'Not author can delete question files' do
    click_on 'Log out'
    log_in(user2)
    visit root_path
    click_on 'its a title'
    expect(page).not_to have_link 'delete file'
  end

end

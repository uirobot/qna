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
    visit question_path(question)
  end

  scenario 'Attachments can delete author', js: true do
    fill_in 'Body', with: 'its my answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Send answer'
    within '.files-attachments' do
      click_on 'delete file'
    end
    expect(page).not_to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'Not author cant delete answer attachments', js: true do
    fill_in 'Body', with: 'its my answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Send answer'
    click_on 'Log out'
    log_in(user2)
    visit question_path(question)
    within '.files-attachments' do
      expect(page).not_to have_link 'delete file'
    end
  end

end

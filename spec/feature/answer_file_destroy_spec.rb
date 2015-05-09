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
    click_on 'add file'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Send answer'
    page.find(".edit-answer").click
    click_on 'delete file'
    expect(page).not_to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end

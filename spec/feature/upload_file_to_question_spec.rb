require_relative 'feature_helper'

feature 'Add files to question', %q{
  In order to share file in question
  Question author
  Can attach files
} do

  given(:user) { create(:user) }

  background do
    log_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'its a title'
    fill_in 'Body', with: 'this is question body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Send question'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'User can add multiple files to question', js: true do
    fill_in 'Title', with: 'its a title'
    fill_in 'Body', with: 'this is question body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'add file'
    within all('.add_file_form').last do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end
    click_on 'Send question'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end

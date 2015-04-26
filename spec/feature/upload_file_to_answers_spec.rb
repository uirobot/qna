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

  scenario 'User adds multiple file when post answer', js: true do
    fill_in 'Body', with: 'its a answer body'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'add file'
    within all('.add_file_form').last do
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    end
    click_on 'Send answer'
    within '.answers-list' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
    end
  end

end

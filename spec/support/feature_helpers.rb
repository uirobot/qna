module FeatureHelpers
  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def attach_files
    click_on 'add file'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'add file'
    within all('.add_file_form').last do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end
  end

end

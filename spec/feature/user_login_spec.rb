require 'rails_helper'

feature 'User register and sign in', %q{
  In order to be able to ask question and provide answers
  User
  can register and can sign in
} do
  given(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    log_in(user)
    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '9876543'
    click_on 'Log in'
    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'User can log out' do
    log_in(user)
    expect(page).to have_content 'Signed in successfully.'
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'User can sign in' do
    visit root_path
    click_on 'Register'
    user_mail = 'new_user@mail.com'
    user_password = 'new_password'
    fill_in 'Email', with: user_mail
    fill_in 'Password', with: user_password
    fill_in 'Password confirmation', with: user_password
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

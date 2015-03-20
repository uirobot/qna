require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question and provide answers
  User
  register and/or can sign in
} do

  scenario 'Registered user try to sign in' do
    User.create(email: "user@test.com", password: 'qwerty1234567')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: 'qwerty1234567'
    click_on 'Log in'

    save_and_open_page

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path

  end

  scenario 'Non registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '9876543'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Пользователь может войти в систему'
  scenario 'Пользователь может выйти из системы'
  scenario 'Пользователь может зарегистрироваться в системе'

end

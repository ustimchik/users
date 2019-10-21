require 'rails_helper'

feature 'User can sign out', %q{
  In order to stop using the application
  As an authenticated user
  I'd like to be able to sign out
} do
  given(:user) { create :user }

  background do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Войти'
  end

  scenario 'Logged in user attempts to sign out' do
    click_on 'Выйти'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
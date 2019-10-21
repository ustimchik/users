require 'rails_helper'

feature 'Admin can edit users created in the system', %q{
  In order to manage registered users
  As an authenticated admin user
  I'd like to be able to edit name, password and comments for any user
} do

  given!(:user) { create(:user)}
  given!(:admin) { create(:user, admin: true)}

  before do
    sign_in(admin)
    visit admin_users_path
    within "#user_#{user.id}" do
      click_on 'Редактировать'
    end
  end

  scenario 'admin is able to change the name of another user' do
    fill_in 'Имя', with: 'Аристарх Тестовый'
    click_on 'Подтвердить'

    expect(page).to have_content 'Аристарх Тестовый'
  end

  scenario 'admin is able to change the comment for another user' do
    fill_in 'Комментарий', with: 'Душный, ломает все'
    click_on 'Подтвердить'

    visit edit_admin_user_path(user)
    expect(find_field('Комментарий').value).to eq 'Душный, ломает все'
  end

  scenario 'admin is able to reset the password of another user' do
    fill_in 'Новый пароль', with: 'definitelyTest123'
    fill_in 'Подтвердите пароль', with: 'definitelyTest123'
    click_on 'Смена пароля'
    click_on 'Выйти'
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'definitelyTest123'
    click_on 'Войти'

    expect(page).to have_content 'Signed in successfully'
  end
end
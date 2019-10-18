require 'rails_helper'

feature 'Admin can view all users created in the system', %q{
  In order to manage registered users
  As an authenticated admin user
  I'd like to be able to view the list of all users
} do

  given!(:users) { create_list(:user, 3)}
  given!(:admin) { create(:user, admin: true)}

  scenario 'Unauthenticated user can not see the list of all users' do
    visit admin_users_path

    users.each do |u|
      expect(page).to_not have_content u.name
      expect(page).to_not have_content u.created_at
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end

  context 'Authenticated user' do
    scenario 'is able to view the list of all users if ADMIN' do
      sign_in(admin)
      visit admin_users_path

      users.each do |u|
        expect(page).to have_content u.name
        expect(page).to have_content u.created_at
      end
    end

    scenario 'is NOT able to view the list of all users if NOT ADMIN' do
      sign_in(users.first)
      visit admin_users_path

      users.each do |u|
        expect(page).to_not have_content u.created_at
        expect(page).to have_content 'You are not authorized to access this page'
      end
    end
  end
end
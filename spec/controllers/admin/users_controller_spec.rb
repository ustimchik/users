require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let!(:users) { create_list(:user, 3) }

  describe 'GET #index' do
    context 'authenticated user' do
      context 'as admin' do

        before do
          users.last.update(admin: true)
          login(users.last)
          get :index
        end

        it 'populates an array of all users' do
          expect(assigns(:users)).to match_array(users)
        end

        it 'renders index view' do
          expect(response).to render_template :index
        end
      end

      context 'as NOT ADMIN' do
        before do
          login(users.first)
          get :index
        end

        it 'does not populate an array of all users' do
          expect(assigns(:users)).to be_empty
        end

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'NOT authenticated user' do
      context 'as NOT ADMIN' do
        before { get :index }

        it 'does not populate an array of all users to @users' do
          expect(assigns(:users)).to be_falsey
        end

        it 'redirects to sign in path' do
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
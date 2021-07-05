require 'rails_helper'

RSpec.describe PagesController, type: :request do

  let(:current_user) { create(:user) }
  let(:pages) { create(:page, user: current_user) }

  before :each do
    login_as current_user
  end

  describe 'GET /users/:user_id/pages' do

    context 'when the user that created the page link is the current user' do

      it 'should return a success response' do      
        get "/users/#{current_user.id}/pages"
        expect(response.code).to eq "200"
      end

      it 'should return the pages for the current user' do
        pages.inspect
        get "/users/#{current_user.id}/pages"
        expect(response.body).to match("https://www.testlink.com/very-very/long-link")
      end
    end

    context 'when the user that created the page link is NOT the current user' do
      let(:another_user) { create(:user) }
      let(:other_pages) { create(:page, :other_users, user: another_user) }

      before :each do
        other_pages.inspect
        login_as another_user
      end

      it 'should NOT show the links another user created' do
        get "/users/#{current_user.id}/pages"
        expect(response.body).not_to match("https://www.testlink.com/very-very/long-link")
      end

      it 'should show the links that this user created' do
        get "/users/#{another_user.id}/pages"
        expect(response.body).to match("https://www.another-users-long-link")
      end
    end
  end
end

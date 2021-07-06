require 'rails_helper'

RSpec.describe PagesController, type: :request do

  let(:current_user) { create(:user) }
  let(:pages) { create(:page, user: current_user) }

  describe 'GET /users/:user_id/pages' do

    context 'when the user that created the page link is the current user' do

      before :each do
        login_as current_user
      end

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

    context 'when no user is logged in' do
      it 'redirects the user to sign in' do
        get "/users/1234567/pages"
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe 'GET /s/:short_url' do
    let(:page) { create(:page, user: current_user) }

    it 'should redirect the user to the full url when the short url is used' do
      get "/s/#{page.short_url}"
      expect(response).to redirect_to(page.long_url)
    end

    it 'should increase the counter for the page when short url is used' do
      expect{
        get "/s/#{page.short_url}"
      }.to change{page.reload.counter}.by(1)
    end

    it 'should render a 404 if a non existent short url is provided' do
      expect {
        get "/s/not-a-shorty"
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'POST /users/:user_id/pages' do

    before :each do
      login_as current_user
    end

    it 'should save the new url if it is valid' do
      expect { 
        current_user.pages.create(long_url: "http://www.this-is-a-valid-address.com")
      }.to change { Page.all.count }.from(0).to(1)
    end

    it 'should not save the new url if it si invalid' do
      current_user.pages.create(long_url: "this is not a valid url")
      expect(Page.all.count).to eq(0)
    end

  end
end

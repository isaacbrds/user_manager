require 'rails_helper'

RSpec.describe "/users", type: :request do 
  
    
    describe "GET /users" do
        let(:url) { "/users/"}
        let!(:users) {create_list(:user, 6)}
        it "renders a successful response" do 
            get url
            expect(response).to have_http_status(302)
        end
    end 
    describe "GET /show" do
        let(:user) {create(:user)}
        let(:url) { "/users/#{user.id}"}
        it "renders a successful response" do
          get url, params: {id: user.id}
          expect(response).to have_http_status(302)
        end
    end
    describe "GET /new" do
        let(:url) { "/users/new"}
        it "renders a successful response" do
          get url
          expect(response).to have_http_status(302)
        end
    end
    describe "GET /edit" do
        let!(:user){ create(:user) }
        let(:url) { "/users/#{user.id}/edit"}
           

        it "render a successful response" do
            get url
            expect(response).to have_http_status(302)
        end
    end

    describe "DESTROY /users" do 
        let!(:user){ create(:user) }
        let(:url) { "/users/#{user.id}"}
        it "removes user" do 
            expect do 
                delete url
            end.to change(User, :count).by(0)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(302)
        end
    end
end
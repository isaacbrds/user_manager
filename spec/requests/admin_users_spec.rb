require 'rails_helper'

RSpec.describe "/users", type: :request do 
    
    before(:each) do
        @current_user = create(:user, role: :admin)
        sign_in @current_user
    end

    
    describe "GET /users" do
        let(:url) { "/users/"}
        let!(:users) {create_list(:user, 6)}
        it "renders a successful response" do 
            get url
            expect(response).to be_successful
        end
    end 

    describe "GET /show" do
        let(:user) {create(:user)}
        let(:url) { "/users/#{user.id}"}
        it "renders a successful response" do
          get url, params: {id: user.id}
          expect(response).to be_successful
        end
    end

    describe "GET /new" do
        let(:url) { "/users/new"}
        it "renders a successful response" do
          get url
          expect(response).to be_successful
        end
      end
    
    describe "GET /edit" do
        let(:user) {create(:user)}
        let(:url) { "/users/#{user.id}/edit"}
        it "render a successful response" do
        get url
        expect(response).to be_successful
        end
    end

    describe "POST /users" do
        
        context "with valid parameters" do

            before(:each) do
                @user_attributes = attributes_for(:user)
                post users_url, params: {user: @user_attributes}
            end

            it "Redirect to new user" do
                expect(response).to have_http_status(302)
                expect(response.body).to redirect_to(user_url(User.last))
            end

            it "Create user with right attributes" do
                expect(User.last.full_name).to eql(@user_attributes[:full_name])            
            end

           
        end
        
        context "with invalid parameters" do
            before(:each) do
                @user_attributes = attributes_for(:user, full_name: nil)
                post users_url, params: {user: @user_attributes}
            end
            it "No redirect" do
                expect(response).to have_http_status(422)
                expect(response.body).to include('full_name')
            end

            it "does not create a new User" do
                expect {
                  post users_url, params: { user:  @user_attributes }
                }.to change(User, :count).by(0)
              end
        end
      end

    describe "PATCH /users" do
        context "with valid parameters" do
            before(:each) do
                user = create(:user)
                @new_user_attributes = attributes_for(:user)
                
                patch "/users/#{user.id}", params: {user: @new_user_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(302)
            end
    
            it "User have the new attributes" do
                expect(User.last.full_name).to eq(@new_user_attributes[:full_name])
            end
        end

        context "with invalid parameters" do
            before(:each) do
                user = create(:user)
                @new_user_attributes = attributes_for(:user, full_name: nil)
                put user_url(user), params: {user: @new_user_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(422)
            end
    
            it "User have the new attributes" do
                expect(User.last.full_name).to_not eq(@new_user_attributes[:full_name])
            end
        end
    end

    describe "DESTROY /users" do 
        let!(:user){ create(:user) }
        let(:url) { "/users/#{user.id}"}
        it "removes user" do 
            expect do 
                delete url
            end.to change(User, :count).by(-1)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(302)
        end
    end
    
end
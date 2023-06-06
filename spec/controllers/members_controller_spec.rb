require 'rails_helper'

describe Api::V1::MembersController, type: :request do
  let(:user) { create_user }
  let(:auth_token) { login_with_api(user) }

  describe 'GET /api/v1/members' do
    context 'When creating a new member' do
      before do
        get '/api/v1/members', headers: { 'Authorization': auth_token }
      end
  
      it 'returns 200' do
        expect(response.status).to eq(200)
      end


      it 'return the first member is equal to current_user' do
        expect(json[0]['username']).to eq(user.username)
      end
    end
  end

  describe 'POST /api/v1/members' do
    context 'When creating a new member' do
      before do
        post '/api/v1/members',
              params: {
                member: {
                  id: rand(1..100),
                  username: 'master_chi',
                  user_id: user.id
                }
              },
              headers: { 'Authorization': auth_token }
      end

      it 'returns ok status' do
        expect(response.status).to eq(201)
      end

      it 'returns the username' do
        expect(json['username']).to eq('master_chi')
      end
    end
  end
end
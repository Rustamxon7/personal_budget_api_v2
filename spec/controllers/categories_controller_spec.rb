require 'rails_helper'

describe Api::V1::CategoriesController, type: :request do
  let(:user) { create_user }
  let(:auth_token) { login_with_api(user) }
  let(:category) { create_category(user) }
  let(:member) { User.find(category.user_id).members.first }

  context 'When creating a new category' do
    before do

      post '/api/v1/categories',
           params: {
             category: {
              name: category.name,
              user_id: category.user_id,
              member_id: member.id
             }
           },
           headers: { 'Authorization': auth_token }
    end

    it 'returns 201' do
      expect(response.status).to eq(201)
    end

    it 'returns the category name' do
      expect(json['name']).to eq(category.name)
    end
  end

  context 'When creating one category for many members' do
    before do
      5.times do
        post '/api/v1/categories',
             params: {
               category: {
                name: category.name,
                user_id: category.user_id,
                members_ids: user.members.map(&:id)
               }
             },
             headers: { 'Authorization': auth_token }
      end
    end

    it 'returns 201' do
      expect(response.status).to eq(201)
    end
    
    it 'returns the members_ids' do
      expect(json['members_ids']).to eq(user.members.map(&:id))
    end
  end
end
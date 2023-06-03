class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :member_id
end

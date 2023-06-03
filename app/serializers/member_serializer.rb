class MemberSerializer < ActiveModel::Serializer
  attributes :id, :username, :user_id, :image
end

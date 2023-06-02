class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :icon, :kind, :members_ids, :user_id, :member_id
end

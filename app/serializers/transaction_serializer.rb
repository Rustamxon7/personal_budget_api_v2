class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :date, :category_id, :group, :member_id

  def date
    object.created_at.strftime("%Y-%m-%d")
  end
end

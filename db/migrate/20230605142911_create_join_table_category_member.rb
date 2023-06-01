class CreateJoinTableCategoryMember < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :members do |t|
      t.index [:category_id, :member_id]
      t.index [:member_id, :category_id]
    end
  end
end

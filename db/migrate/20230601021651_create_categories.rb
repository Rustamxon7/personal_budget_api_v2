class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ""
      t.string :icon, null: false, default: ""
      t.integer :members_ids, array: true, default: []
      t.string :kind, default: 'expense', null: false
      
      t.references :user, foreign_key: true
      t.references :member, foreign_key: true
      t.timestamps
    end
  end
end

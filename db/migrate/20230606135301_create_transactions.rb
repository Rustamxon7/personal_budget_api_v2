class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :name, null: false, default: ""
      t.string :group, null: false, default: ""
      t.decimal :amount, precision: 10, scale: 2, default: 0

      t.references :category, foreign_key: true
      t.references :member, foreign_key: true
      t.timestamps
    end
  end
end

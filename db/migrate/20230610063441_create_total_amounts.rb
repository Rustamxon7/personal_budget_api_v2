class CreateTotalAmounts < ActiveRecord::Migration[7.0]
  def change
    create_table :total_amounts do |t|
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.string :kind, null: false, default: "expense"
      t.references :member, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

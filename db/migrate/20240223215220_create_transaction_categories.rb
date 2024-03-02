class CreateTransactionCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_categories do |t|
      t.integer :transaction_id
      t.integer :category_id

      t.timestamps
    end

    add_foreign_key :transaction_categories, :transactions
    add_foreign_key :transaction_categories, :categories
  end
end

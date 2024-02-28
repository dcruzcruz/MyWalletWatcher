class CreateTransactionCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_categories do |t|
      t.belongs_to :transaction, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end

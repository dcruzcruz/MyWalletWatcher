# db/migrate/20240224000000_create_transactions.rb

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.references :household_member, foreign_key: true
      t.string :transaction_type
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.string :description

      t.timestamps
    end
  end
end

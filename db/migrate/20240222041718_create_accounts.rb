class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
    t.belongs_to :household_member, index: true, foreign_key: true
    t.string :account_name
    t.decimal :balance, precision: 10, scale: 2
    t.timestamps
    end
  end
end

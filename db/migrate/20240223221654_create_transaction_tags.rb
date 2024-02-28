class CreateTransactionTags < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_tags do |t|
      t.belongs_to :transaction, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
      t.timestamps
    end
  end
end

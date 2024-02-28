class TransactionTag < ApplicationRecord
  belongs_to :transaction_record_2, class_name: 'Transaction', foreign_key: 'transaction_id'
  belongs_to :tag
end

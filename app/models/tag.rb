class Tag < ApplicationRecord
  has_many :transaction_tags
  has_many :transactions, through: :transaction_tags
end

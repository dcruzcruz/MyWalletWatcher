class Category < ApplicationRecord
  has_many :transaction_categories
  has_many :transactions, through: :transaction_categories
end

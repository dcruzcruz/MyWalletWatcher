class Transaction < ApplicationRecord
  self.inheritance_column = 'not_sti_column' # Choose a column name other than 'type'
  belongs_to :account
  belongs_to :household_member

  has_many :transaction_categories, foreign_key: :transaction_id, dependent: :destroy
  has_many :categories, through: :transaction_categories, dependent: :destroy
  has_many :transaction_tags, foreign_key: :transaction_id, dependent: :destroy
  has_many :tags, through: :transaction_tags, dependent: :destroy

  accepts_nested_attributes_for :transaction_categories
  accepts_nested_attributes_for :transaction_tags

  validates :transaction_type, presence: true, inclusion: { in: %w(Income Expense) }
  validates :amount, presence: true, numericality: true
  validates :date, presence: true
  validates :description, presence: true

  after_create :update_account_balance

  def update_account_balance
    if transaction_type == 'Income'
      account.update(balance: account.balance + amount)
    elsif transaction_type == 'Expense' && account.balance >= amount
      account.update(balance: account.balance - amount)
    else
      # In the context of seed data handle the error differently
      # For example, the output a warning message to the console.
      puts "Warning: Invalid transaction type or insufficient account balance for seed data."
    end
  end
end
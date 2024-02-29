class Account < ApplicationRecord
  belongs_to :household_member
  has_many :transactions, dependent: :destroy
  has_many :institutions

  validates :account_name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def update_balance!
    update(balance: transactions.sum(:amount))
  end
end
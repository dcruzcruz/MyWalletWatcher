class HouseholdMember < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :transactions

  validates :name, presence: true

  # Example method to get the total balance across all member accounts
  def total_balance
    accounts.sum(:balance)
  end
end
class HouseholdMember < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :transactions

  validates :name, presence: true

  def total_balance
    accounts.sum(:balance)
  end
end
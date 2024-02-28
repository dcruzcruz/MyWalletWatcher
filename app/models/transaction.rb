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

  private

  def update_account_balance
    account.update_balance!
  end
end
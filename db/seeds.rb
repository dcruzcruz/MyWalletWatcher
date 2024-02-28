# seeds.rb
require 'faker'

# Helper method to generate random date between two dates
def random_date_in_range(from, to)
  rand(from..to)
end

# Create categories
category_names = ['Groceries', 'Utilities', 'Entertainment']
categories = category_names.map { |name| Category.create(category_name: name) }

# Create tags
tag_names = ['Personal', 'Business']
tags = tag_names.map { |name| Tag.create(tag_name: name) }

# Create 5 household members
5.times do
  household_member = HouseholdMember.create(name: Faker::Name.name)

  # Create 5 accounts for each household member
  5.times do
    account = Account.create(
      household_member: household_member,
      account_name: Faker::Bank.name,
      balance: Faker::Number.decimal(l_digits: 4, r_digits: 2)
    )

    # Create 40 transactions for each account
    40.times do
      transaction_type = Faker::Number.between(from: 0, to: 1).zero? ? 'Expense' : 'Income'
      amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)
      date = random_date_in_range(Date.new(2023, 1, 1), Date.today)
      description = Faker::Lorem.sentence

      transaction = Transaction.new(
        account: account,
        household_member: household_member,
        transaction_type: transaction_type,
        amount: amount,
        date: date,
        description: description
      )

      if transaction.save
        puts "Transaction created successfully: #{transaction.id}"

        # Assign a random category to the transaction
        transaction_category = TransactionCategory.new(transaction_record: transaction, category: categories.sample)
        transaction_category.save

        # Assign a random tag to the transaction
        transaction_tag = TransactionTag.new(transaction_record_2: transaction, tag: tags.sample)
        transaction_tag.save
      else
        puts "Error creating Transaction: #{transaction.errors.full_messages.join(', ')}"
      end
    end
  end
end

puts 'Seed data has been successfully added.'

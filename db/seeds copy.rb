# seeds.rb

# Create household members
household_member1 = HouseholdMember.create(name: 'John Doe')
household_member2 = HouseholdMember.create(name: 'Jane Doe')

# Create accounts
account1 = Account.create(household_member: household_member1, account_name: 'Savings Account', balance: 1000.00)
account2 = Account.create(household_member: household_member2, account_name: 'Checking Account', balance: 500.00)

# Create categories
category1 = Category.create(category_name: 'Groceries')
category2 = Category.create(category_name: 'Utilities')
category3 = Category.create(category_name: 'Entertainment')

# Create tags
tag1 = Tag.create(tag_name: 'Personal')
tag2 = Tag.create(tag_name: 'Business')

# Create transactions
transaction1 = Transaction.new(account: account1, household_member: household_member1, transaction_type: 'Expense', amount: 50.00, date: Date.today, description: 'Grocery shopping')
if transaction1.save
  puts 'Transaction 1 created successfully'
else
  puts "Error creating Transaction 1: #{transaction1.errors.full_messages.join(', ')}"
end

transaction2 = Transaction.new(account: account2, household_member: household_member2, transaction_type: 'Income', amount: 200.00, date: Date.today, description: 'Salary deposit')
if transaction2.save
  puts 'Transaction 2 created successfully'
else
  puts "Error creating Transaction 2: #{transaction2.errors.full_messages.join(', ')}"
end

# Associate transactions with categories and tags
transaction_category1 = TransactionCategory.new(transaction_record: transaction1, category: category1)
if transaction_category1.save
  puts 'TransactionCategory 1 created successfully'
else
  puts "Error creating TransactionCategory 1: #{transaction_category1.errors.full_messages.join(', ')}"
end

transaction_tag1 = TransactionTag.new(transaction_record_2: transaction1, tag: tag1)
if transaction_tag1.save
  puts 'TransactionTag 1 created successfully'
else
  puts "Error creating TransactionTag 1: #{transaction_tag1.errors.full_messages.join(', ')}"
end

transaction_category2 = TransactionCategory.new(transaction_record: transaction2, category: category3)
if transaction_category2.save
  puts 'TransactionCategory 2 created successfully'
else
  puts "Error creating TransactionCategory 2: #{transaction_category2.errors.full_messages.join(', ')}"
end

transaction_tag2 = TransactionTag.new(transaction_record_2: transaction2, tag: tag2)
if transaction_tag2.save
  puts 'TransactionTag 2 created successfully'
else
  puts "Error creating TransactionTag 2: #{transaction_tag2.errors.full_messages.join(', ')}"
end

puts 'Seed data has been successfully added.'
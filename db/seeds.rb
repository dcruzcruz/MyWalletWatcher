# db/seeds.rb
require 'csv'
require 'faker'

# Helper method to handle CSV import
def import_institutions_from_csv(file_path)
  CSV.foreach(file_path, headers: true) do |row|
    institution_params = {
      name: row['name'],
      latitude: row['latitude'],
      longitude: row['longitude']
    }

    institution = Institution.new(institution_params)
    if institution.save
      puts "Institution created successfully: #{institution.name}"
    else
      puts "Error creating Institution: #{institution.errors.full_messages.join(', ')}"
    end
  end
end

# Create categories
csv_text_categories = File.read(Rails.root.join('db/csv/', 'categories.csv'))
csv_categories = CSV.parse(csv_text_categories, headers: true)
categories = csv_categories.map { |row| Category.create(category_name: row['category_name']) }


# Create tags
csv_tag_names = File.read(Rails.root.join('db/csv/', 'tags.csv'))
csv_tags = CSV.parse(csv_tag_names, headers: true)
tags = csv_tags.map { |row| Tag.create(tag_name: row['tag_name']) }

# Helper method to create random date between two dates
def random_date_in_range(from, to)
  rand(from..to)
end

# Specify the path to your CSV file
csv_file_path = 'db/csv/institutions.csv'

if File.exist?(csv_file_path)
  import_institutions_from_csv(csv_file_path)

# Create 4 household members
csv_members_names = File.read(Rails.root.join('db/csv/', 'household_members.csv'))
csv_members = CSV.parse(csv_members_names, headers: true)
household_members = csv_members.map { |row| HouseholdMember.create(name: row['name']) }

# Create 4 accounts for each household member and assign a random institution
csv_text_accounts = File.read(Rails.root.join('db/csv/', 'accounts.csv'))
csv_accounts = CSV.parse(csv_text_accounts, headers: true)

csv_accounts.each do |row|
  account = Account.create(
    household_member_id: household_members.sample.id, # Randomly select a household member
    institution_id: row['institution_id'],
    account_name: row['account_name'],
    balance: row['balance']
  )

  # Create 25 transactions for each account with random categories and tags
  25.times do
    transaction_type = Faker::Number.between(from: 0, to: 1).zero? ? 'Expense' : 'Income'
    amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    date = random_date_in_range(Date.new(2024, 1, 1), Date.today)
    description = Faker::Lorem.sentence

    transaction = Transaction.new(
      account: account,
      household_member: household_members.sample, # Randomly select a household member
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

  puts 'Seed data has been successfully added.'
else
  puts "CSV file not found at #{csv_file_path}. Please provide the correct path."
end
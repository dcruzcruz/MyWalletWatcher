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
category_names = ['Groceries', 'Utilities', 'Entertainment']
categories = category_names.map { |name| Category.create(category_name: name) }

# Create tags
tag_names = ['Personal', 'Business']
tags = tag_names.map { |name| Tag.create(tag_name: name) }

# Helper method to create random date between two dates
def random_date_in_range(from, to)
  rand(from..to)
end

# Specify the path to your CSV file
csv_file_path = 'db/csv/institutions.csv'

if File.exist?(csv_file_path)
  import_institutions_from_csv(csv_file_path)

  # Create 4 household members
  household_members = 4.times.map do
    HouseholdMember.create(name: Faker::Name.name)
  end

  # Create 4 accounts for each household member and assign a random institution
  household_members.each do |household_member|
    4.times do
      # Generate a random number
      random_number = Faker::Number.number(digits: 12)
      # Choose a random account type
      account_types = ['Chequing', 'Savings', 'Money MF', 'GICs']
      random_account_type = account_types.sample
      # Concatenate the random number and account type to create the account name
      account_name = "#{random_account_type} #{random_number}"
      account = Account.create(
        household_member: household_member,
        account_name: account_name,
        balance: Faker::Number.decimal(l_digits: 4, r_digits: 2),
        institution_id: Institution.all.sample.id
      )

      # Create 25 transactions for each account with random categories and tags
      25.times do
        transaction_type = Faker::Number.between(from: 0, to: 1).zero? ? 'Expense' : 'Income'
        amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)
        date = random_date_in_range(Date.new(2024, 1, 1), Date.today)
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
else
  puts "CSV file not found at #{csv_file_path}. Please provide the correct path."
end
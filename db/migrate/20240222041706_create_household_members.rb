class CreateHouseholdMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :household_members do |t|
      t.string :name
      t.timestamps
    end
  end
end

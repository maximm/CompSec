class AddFNameS1ToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :firstNameStil1, :string
    add_column :users, :lastNameStil1, :string
    add_column :users, :firstNameStil2, :string
    add_column :users, :lastNamestil2, :string
        
  end

  def self.down
    remove_column :users, :name
  end
end

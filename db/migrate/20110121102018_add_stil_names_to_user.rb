class AddStilNamesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :stil1, :string
    add_column :users, :stil2, :string    
  end

  def self.down
  end
end

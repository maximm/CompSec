class CreateLinuxtries < ActiveRecord::Migration
  def self.up
    create_table :linuxtries do |t|
      t.column :username, :string
      t.column :trynbr, :integer
      t.column :seed, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :linuxtries
  end
end

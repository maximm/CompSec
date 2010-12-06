class CreateFilehandlers < ActiveRecord::Migration
  def self.up
    create_table :filehandlers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :filehandlers
  end
end

class CreateStudentusers < ActiveRecord::Migration
  def self.up
    create_table :studentusers do |t|
      t.string :stil
      t.boolean :project0
      t.boolean :project1
      t.boolean :project2
      t.boolean :project3
      t.boolean :project4
      t.boolean :project5

      t.timestamps
    end
  end

  def self.down
    drop_table :studentusers
  end
end

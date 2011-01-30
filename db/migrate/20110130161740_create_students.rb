class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :masters
      t.integer :age
      t.boolean :sex
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end

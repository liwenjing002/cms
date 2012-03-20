class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.integer :type_id
      t.string :age_range
      t.string :name
      t.text :desc

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end

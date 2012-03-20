class CreatePageTemps < ActiveRecord::Migration
  def self.up
    create_table :page_temps do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
    add_column :forums,:page_temp_id,:integer
  end

  def self.down
    drop_table :page_temps
     remove_column :forums,:page_temp_id
  end
end

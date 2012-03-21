class AddTempToArticleCourse < ActiveRecord::Migration
  def self.up
   add_column :articles,:page_temp_id,:integer
    add_column :courses,:page_temp_id,:integer
  end

  def self.down
  	 remove_column :articles,:page_temp_id
    remove_column :courses,:page_temp_id
  end
end

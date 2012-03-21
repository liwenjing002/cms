class AddTempType < ActiveRecord::Migration
  def self.up
  	add_column :page_temps,:temp_type,:string
  end

  def self.down
  	remove_column :page_temps,:temp_type
  end
end

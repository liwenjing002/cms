class PageTempFlag < ActiveRecord::Migration
  def self.up
  	add_column :page_temps,:is_acticity,:boolean
  end

  def self.down
  	remove_column :page_temps,:is_acticity
  end
end

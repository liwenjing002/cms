class AddSome < ActiveRecord::Migration
  def self.up
  	add_column :ckeditor_assets,:data_fingerprint,:string
  end

  def self.down
  end
end

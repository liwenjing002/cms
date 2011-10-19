class CreateUsePermissions < ActiveRecord::Migration
  def self.up
    create_table :use_permissions do |t|
	  t.integer :user_id
	  t.integer :permission_id
      t.timestamps
    end
  end

  def self.down
    drop_table :use_permissions
  end
end

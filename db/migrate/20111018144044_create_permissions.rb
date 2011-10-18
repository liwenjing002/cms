class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :name
      
      t.timestamps
    end
    
    Permission.create({:name=>"Article"})
    Permission.create({:name=>"User"})
    Permission.create({:name=>"Forum"})
    Permission.create({:name=>"Message"})
  end

  def self.down
    drop_table :permissions
  end
end

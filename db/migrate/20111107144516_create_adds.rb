class CreateAdds < ActiveRecord::Migration
  def self.up
    create_table :adds do |t|
      t.string :name
      t.integer :picture_id
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :adds
  end
end

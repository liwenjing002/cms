class CreateApplies < ActiveRecord::Migration
  def self.up
    create_table :applies do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :qq
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :applies
  end
end

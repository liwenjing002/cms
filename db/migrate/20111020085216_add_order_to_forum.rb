class AddOrderToForum < ActiveRecord::Migration
  def self.up
    add_column :forums,:order_num,:integer
  end

  def self.down
     remove_column :forums,:order_num
  end
end

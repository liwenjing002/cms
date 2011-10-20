class InitDate < ActiveRecord::Migration
  def self.up
      Forum.create({:name=>"通知公告",:order_num=>0})
     Forum.create({:name=>"资讯中心 ",:order_num=>1})
    Forum.create({:name=>"资讯中心 ",:order_num=>1})
    Forum.create({:name=>"政策法规",:order_num=>2})
    Forum.create({:name=>"标准规范",:order_num=>3})
    Forum.create({:name=>"公报年报",:order_num=>4})
    Forum.create({:name=>"业内专家",:order_num=>5})
    Forum.create({:name=>"招投标信息",:order_num=>6})
    Forum.create({:name=>"最新环保技术和产品",:order_num=>7})
    Forum.create({:name=>"环境标准",:order_num=>8})
    Forum.create({:name=>"科普知识",:order_num=>9})
  end

  def self.down
  end
end

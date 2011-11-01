# encoding: utf-8
class AddCodeToForum < ActiveRecord::Migration
  def self.up
    remove_column :articles,:second_forum_id
    add_column :articles,:forum_id ,:integer
    add_column :forums ,:code,:string
    Forum.create({:name=>"通知公告",:order_num=>0,:code=>"tongzhi"})
    Forum.create({:name=>"资讯中心 ",:order_num=>1,:code=>"zixun"})
    Forum.create({:name=>"政策法规",:order_num=>2,:code=>"zhence"})
    Forum.create({:name=>"标准规范",:order_num=>3,:code=>"guifang"})
    Forum.create({:name=>"公报年报",:order_num=>4,:code=>"gongbao"})
    Forum.create({:name=>"办事指南",:order_num=>5,:code=>"huanbaozhinan"})
    Forum.create({:name=>"招投标信息",:order_num=>6,:code=>"zhaobiao"})
    Forum.create({:name=>"最新技术",:order_num=>7,:code=>"jishu"})
    Forum.create({:name=>"环境标准",:order_num=>8,:code=>"biaozhun"})
    Forum.create({:name=>"科普知识",:order_num=>9,:code=>"kepu"})


    f = Forum.find_by_code("zixun")
    Forum.create({:name=>"头条新闻",:order_num=>1,:code=>"toutiao",:father_id=>f.id})
     Forum.create({:name=>"国内新闻",:order_num=>1,:code=>"guoneixinwen",:father_id=>f.id})
     Forum.create({:name=>"国际新闻",:order_num=>1,:code=>"guojixinwen",:father_id=>f.id})
     Forum.create({:name=>"杭州动态",:order_num=>1,:code=>"hangzhoudongtai",:father_id=>f.id})
     Forum.create({:name=>"协会动态",:order_num=>1,:code=>"xiehuidongtai",:father_id=>f.id})
     Forum.create({:name=>"图片新闻",:order_num=>1,:code=>"tupianxinwen",:father_id=>f.id})

    f = Forum.find_by_code("jishu")
    Forum.create({:name=>"环保培训",:order_num=>1,:code=>"huanbaopeixun",:father_id=>f.id})
     Forum.create({:name=>"科普知识",:order_num=>1,:code=>"kepuzhishi",:father_id=>f.id})
     Forum.create({:name=>"最新环保技术、产品",:order_num=>1,:code=>"jishuchangping",:father_id=>f.id})
     Forum.create({:name=>"示范工程",:order_num=>1,:code=>"shifanggongcheng",:father_id=>f.id})
     Forum.create({:name=>"实用技术",:order_num=>1,:code=>"shiyongjishu",:father_id=>f.id})


  end

  def self.down
   add_column :articles,:second_forum_id,:integer
  remove_column :articles,:forum_id
  remove_column :forums ,:code
  end
end

class Add < ActiveRecord::Base
  validates_presence_of :name,:message => "名称不为空"
validates_presence_of :url,:message => "广告链接不为空"
  belongs_to :picture,:class_name=>"Ckeditor::Picture"
end

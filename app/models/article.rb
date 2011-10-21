class Article < ActiveRecord::Base
belongs_to :first_forum,:class_name =>"Forum"
belongs_to :forum
belongs_to :father_forum,:foreign_key => "second_forum_id"
validates_presence_of :title,:message => "标题不为空"
validates_presence_of :context,:message => "正文不为空"
belongs_to :user
belongs_to :picture,:class_name=>"Ckeditor::Picture"
end

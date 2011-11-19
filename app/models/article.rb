# encoding: utf-8
class Article < ActiveRecord::Base
belongs_to :first_forum,:class_name =>"Forum"
belongs_to :forum
belongs_to :father_forum,:class_name=>"Forum",:foreign_key => "first_forum_id"
validates_presence_of :title,:message => "标题不为空"
validates_presence_of :context,:message => "正文不为空"
belongs_to :user
belongs_to :picture,:class_name=>"Ckeditor::Picture"

    before_save :fix_ckeditor_attachment_paths

  def fix_ckeditor_attachment_paths
    if self.context.index(/_cke_saved_href/)
      self.context = self.context.gsub(/_cke_saved_href/, 'href')
    end
  end
end

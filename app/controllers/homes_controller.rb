# encoding: utf-8
class HomesController < ApplicationController
  #caches_page :index, :forums,:articles
   before_filter :get_head

  def index
    
    @toutiao_xinwen = Forum.find_by_code('toutiao').articles(:order=>"update_at desc",:limit=>"9")
    @guonei_xinwen = Forum.find_by_code('guoneixinwen').articles(:order=>"upate_at desc",:limit=>"10")
    @template_id = "1"
    render :layout=>"home"+@template_id
  end

  def get_head
    @forum_first = Forum.find(:all,:conditions=>["father_id is null and order_num > 0 and order_num <11"])
  end

  def forums
    @forum = Forum.find(params[:id])
    articles = @forum.articles_father.length >0 ? @forum.articles_father : @forum.articles
    @articles = articles.paginate :page => params[:page]||1,
                            :per_page=>5
     @template_id = "1"
    render :layout=>"home"+@template_id
  end

  def articles
    @article = Article.find(params[:id])
    if @article.read_num
    @article.read_num +=1
    else
      @article.read_num = 0
    end
    @article.save
     @template_id = "1"
    render :layout=>"home"+@template_id
  end

def read
  @article = Article.find(params[:id])
    if @article.read_num
    @article.read_num +=1
    else
      @article.read_num = 0
    end
    @article.save
     render :text =>"SUCCESS"
end


end

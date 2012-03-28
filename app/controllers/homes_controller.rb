# encoding: utf-8

class HomesController < ApplicationController 
  caches_page :index, :forums,:articles
  before_filter :get_head
  layout "home"

  def index

  end

  def get_head
    @forum_first = Forum.find(:all,:conditions=>["father_id is null and order_num > 0 and order_num <11"])
  end

  def forums
    @forum = Forum.find(params[:id])
    articles = @forum.articles_father.length >0 ? @forum.articles_father : @forum.articles
    @articles = articles.paginate :page => params[:page]||1,
                            :per_page=>10
  end

  def articles
    @article = Article.find(params[:id])
    if @article.read_num
    @article.read_num +=1
    else
      @article.read_num = 0
    end
    @article.save
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

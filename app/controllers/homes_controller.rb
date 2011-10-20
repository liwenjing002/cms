class HomesController < ApplicationController
  
  def index
    @forum_first = Forum.find(:all,:conditions=>["father_id is null and order_num > 0 and order_num <10"])
    @toutiao_xinwen = Forum.find_by_code('toutiao').articles(:order=>"create_at desc",:limit=>"9")
    @guonei_xinwen = Forum.find_by_code('guoneixinwen').articles(:order=>"create_at desc",:limit=>"10")
    render :layout=>"home1"
  end
end

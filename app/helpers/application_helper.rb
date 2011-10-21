# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def is_login
    session[:is_login]
  end

  def get_login_name
    session[:login_name]
  end

  def show_error_in_chinese(errors)
    errors.each{ |key, msg| yield msg}

  end
  def  error_messages_for(object_name)
    object = instance_variable_get("@#{object_name}")
    if object && !object.errors.empty?
      error_lis = []
      object.errors.each{ |key, msg| error_lis << content_tag("li", msg) }
      content_tag("div", content_tag( "h2", "哦哦~~~出错了" ) + \
          content_tag("ul", error_lis), "id" =>  "errorExplanation", \
          "class" =>  "errorExplanation" )
    end
  end

  def get_flash(type)
    if flash!= nil && flash.length!=0
      if type=='notice'
        content_tag("div", flash[:notice], "id" =>  "notice", "class" =>  "notice" )
      elsif type=='errorExplanation'
        content_tag("div", content_tag( "h2", "哦哦~~~请注意" ) +\
            content_tag("ul")+content_tag("li", flash[:notice]),\
            "id" =>  "errorExplanation", "class" =>  "errorExplanation" )
      end
    end
  end
  #html内容切割
  def strip_html(text,len=0,endss="...")
    if text.length>0
      ss=text.gsub(/<\/?[^>]*>/,"")

      if len>0 && ss.length>0
        ss = truncate_u(ss,len,endss)
      end
    end
    return ss
  end
  
  def truncate_u(text, length = 30, truncate_string = "...")
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end

  def forum_tab forum
    if forum
      if forum.father ==nil
        return  link_to("首页","/") +  "→ "+  link_to(forum.name,forums_homes_path(forum))

      end
      if forum.father!= nil
        return    link_to("首页","/") +  "→ "+  link_to(forum.father.name,forums_homes_path(forum.father))+  "→ "+  link_to(forum.name,forums_homes_path(forum))
      end
    end
  end
  
end
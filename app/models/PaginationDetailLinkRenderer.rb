class PaginationDetailLinkRenderer < WillPaginate::LinkRenderer  
  
  def to_html  
    links = @options[:page_links] ? windowed_links : []  
    links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label])  
    links.push    page_link_or_span(@collection.next_page,     'disabled next_page', @options[:next_label])  
    html = links.join(@options[:separator])  
    html = "每页显示<b>#{@collection.per_page}</b>条数据,共有<b>#{total_pages}</b>页,  共有<b>#{@collection.total_entries}</b>条数据" + html  
    @options[:container] ? @template.content_tag(:div, html, html_attributes) : html  
  end  

  protected

    def url_for(page)

       controller_name = @template.controller_name

       action_name = @template.action_name      

       params = @template.request.params

       if contoller_name == "homes"   #到了我们要自定义的action了

           if action_name == "forums"

               return "/homes/forums/#{params[:id]/#{page}"

           end

       else

          super(page) #调用WillPaginate的默认生成的url

       end
     end
  
end
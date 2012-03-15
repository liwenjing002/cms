class PaginationDetailLinkRenderer < WillPaginate::LinkRenderer  
  
 

     protected
    def url_for(page)

       controller_name = @template.controller_name

       action_name = @template.action_name      

       params = @template.request.params

       if contoller_name == "homes"   #到了我们要自定义的action了

           #if action_name == "forums"
               return "/homes/forums/#{params[:id]}/#{page}"
           #end
       else
          super(page) #调用WillPaginate的默认生成的url
      end
  end
end
  
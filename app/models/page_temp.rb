class PageTemp < ActiveRecord::Base

    before_save :chang_html

  def chang_html
      self.content = self.content.gsub(/&lt;\%/, '<%')
       self.content = self.content.gsub(/\%&gt;/, '%>')
  end

	def validate  

		if temp_type=='主页' and is_acticity==true
        	 p = PageTemp.find(:all,:conditions=>"temp_type='主页' and is_acticity = true")
        	 if p and p[0].id != id
        	 	puts id
        	 	errors.add_to_base("主页模板只能生效一个")  
        	 end
      	end 
	end


end

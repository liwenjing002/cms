class Article < ActiveRecord::Base
belongs_to :first_forum,:class_name =>"Forum"
belongs_to :second_forum,:class_name =>"Forum"
end

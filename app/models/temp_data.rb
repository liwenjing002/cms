require "erb"
class TempData
  # attr_accessor :y
  # # def initialize()
  # #   # @showData= Hash.new
  # # end
  # def get_binding
  #   binding
  # end



  def initialize( code, name, desc, cost )
    @code = code
    @name = name
    @desc = desc
    @cost = cost

    @features = [ ]
  end

  def add_feature( feature )
    @features << feature
  end

  # Support templating of member data.
  def get_binding
    binding
  end
end
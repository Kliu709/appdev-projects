class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def inwords 
    self.strftime("%a %e, %R %p")
  end 
end

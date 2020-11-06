class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def full_name
    "#{last_name}#{first_name}"
  end
  

end

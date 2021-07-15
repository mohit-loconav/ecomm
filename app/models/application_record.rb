class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private def capitalize_name
    self.name.capitalize!
  end
end

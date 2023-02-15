class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.with_force_authentication
    safer_initialize do |record|
      if (ability = RequestStore.store[:current_ability])
        ability.authorize! :read, record
      else
        true
      end
    end
  end
end

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  CURRENT_ABILITY_KEY = :current_ability

  def self.with_force_authentication
    safer_initialize do |record|
      if (ability = RequestStore.store[CURRENT_ABILITY_KEY])
        ability.authorize! :read, record
      else
        true
      end
    end
  end
end

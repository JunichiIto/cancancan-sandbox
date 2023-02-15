class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.with_force_authentication
    safer_initialize do |record|
      if RequestStore.store.key?(:current_user)
        user = RequestStore.store[:current_user]
        Ability.new(user).authorize! :read, record
      else
        true
      end
    end
  end
end

class Project < ApplicationRecord
  safer_initialize do |project|
    if RequestStore.store.key?(:current_user)
      user = RequestStore.store[:current_user]
      Ability.new(user).authorize! :read, project
    else
      true
    end
  end
end

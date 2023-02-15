class Project < ApplicationRecord
  safer_initialize message: self.to_s do |project|
    if RequestStore.store.key?(:current_user)
      user = RequestStore.store[:current_user]
      Ability.new(user).can? :read, project
    else
      true
    end
  end
end

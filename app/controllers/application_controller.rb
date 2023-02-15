class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action -> { RequestStore.store[:current_ability] = current_ability }
end

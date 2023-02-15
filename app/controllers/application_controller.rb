class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action -> { RequestStore.store[:current_user] = current_user }
end

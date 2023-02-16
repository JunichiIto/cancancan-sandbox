class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :store_current_ability

  private

  def store_current_ability
    RequestStore.store[ApplicationRecord::CURRENT_ABILITY_KEY] = current_ability
  end
end

SaferInitialize.configure do |config|
  config.error_handle = -> (e) {
    raise CanCan::AccessDenied.new("Not authorized!", :read, e.message.constantize)
  }
end

require "notifications_opener/version"
require "notifications_opener/message"
require "notifications_opener/response_handler"
require "notifications_opener/interceptor"

module NotificationsOpener
  def self.configure
    c = { }
    yield(c)
    ins = Interceptor.new(c)
  end
end

require "notifications_opener/version"
require "notifications_opener/message"
require "notifications_opener/response_handler"
require "notifications_opener/interceptor"
require 'fileutils'

module NotificationsOpener
  def self.configure
    c = { }
    yield(c)
    create_storage_directory(c)
    ins = Interceptor.new(c)
  end

  private

  def self.create_storage_directory(c)
    c[:location] += '/notifications_opener'
    FileUtils.mkdir_p(c[:location])
  end
end

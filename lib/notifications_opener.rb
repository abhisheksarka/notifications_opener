require "notifications_opener/version"
require "notifications_opener/handler/handler"
require "notifications_opener/response_handler"
require "notifications_opener/interceptor"
require 'fileutils'

module NotificationsOpener

  # #
  # Configure the module by passing required options
  #
  # * url - The SMS API URL
  # * location - Generated preview files will stored here, usually tmp
  # * from_key_name - The parameter name you pass to the SMS API that identifies the sender
  # * to_key_name - The parameter name you pass to the SMS API that identifies the receiver
  # * message_key_name - The parameter name you pass to the SMS API that identifies the message
  def self.configure(type=:sms)
    c = { }
    yield(c)
    create_storage_directory(c)
    ins = Interceptor.new(c, type)
    ins.intercept_and_redirect_to_rack_app
    ins
  end

  private

  def self.create_storage_directory(c)
    c[:location] += '/notifications_opener'
    FileUtils.mkdir_p(c[:location])
  end
end

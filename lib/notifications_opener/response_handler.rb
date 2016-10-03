module NotificationsOpener
  ##
  # The (instance of)class represents a Rack application
  # Responsible to handle a stubbed request manually
  class ResponseHandler
    attr_accessor :config,
                  :type,
                  :message

    def initialize(config, type)
      @config = config
      @type = type
    end

    def call(env)
      @message = Object
                  .const_get("NotificationsOpener::Handler::#{type.capitalize}")
                  .new(config, env)

      message.deliver
      [200, {}, []]
    end
  end
end

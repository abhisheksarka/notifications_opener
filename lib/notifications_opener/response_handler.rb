##
# The (instance of)class represents a Rack application
# Responsible to handle a stubbed request manually

module NotificationsOpener
  class ResponseHandler
    attr_accessor :config,
                  :message

    def initialize(config)
      @config = config
    end

    def call(env)
      @message = NotificationsOpener::Message.new(get_required_params(env['QUERY_STRING']))
      message.deliver

      [200, { }, [ ]]
    end

    private

    def get_required_params(q)
      p = get_params_from_query_string(q)
      {
        from: p[config[:from_key_name]],
        to: p[config[:to_key_name]],
        message: URI.decode(p[config[:message_key_name]]),
        location: config[:location]
      }
    end

    def get_params_from_query_string(q)
      p = { }
      q.split('&').each do | kv |
        kv = kv.split('=')
        p[kv[0]] = kv[1]
      end
      p p
      p
    end
  end
end

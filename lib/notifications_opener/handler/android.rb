require 'json'

module NotificationsOpener
  module Handler
    class Android < Base
      attr_accessor :to,
                    :message,
                    :title,
                    :params

      def initialize(config, env)
        super(config, env)
        @params = JSON.parse(env["rack.input"].read)
        @to = @params['to']
        @message = @params['data']['message']
        @title = @params['data']['title']
      end

      def notification_type
        'android'
      end
    end
  end
end

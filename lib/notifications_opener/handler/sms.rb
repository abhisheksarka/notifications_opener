module NotificationsOpener
  module Handler
    class Sms < Base
      attr_accessor :from,
                    :to,
                    :message

      def initialize(config, env)
        super(config, env)
        c = build_params(env['QUERY_STRING'])
        @from = c[:from]
        @to = c[:to]
        @message = c[:message]
      end

      def notification_type
        'sms'
      end

      private

      def build_params(q)
        p = { }

        q.split('&').each do |kv|
          kv = kv.split('=')
          p[kv[0]] = kv[1]
        end

        {
          from: p[config[:from_key_name]],
          to: p[config[:to_key_name]],
          message: URI.decode(p[config[:message_key_name]]),
          location: config[:location]
        }
      end
    end
  end
end

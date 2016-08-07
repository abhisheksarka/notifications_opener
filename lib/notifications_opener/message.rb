module NotificationsOpener
  class Message
    attr_accessor :config
    def initialize(config)
      @config = config
    end

    def from
      @config[:from]
    end

    def to
      @config[:to]
    end

    def message
      @config[:message]
    end

    def deliver
      puts "Delivering message from #{from} to #{to} with #{message}"
    end
  end
end

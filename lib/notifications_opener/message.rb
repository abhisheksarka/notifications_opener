require 'erb'

module NotificationsOpener
  class Message
    attr_accessor :config,
                  :from,
                  :to,
                  :message

    def initialize(config)
      @config = config
      @from = config[:from]
      @to = config[:to]
      @message = config[:message]
    end

    def deliver
      file = rendered_file
      #Launchy.open("file:///#{URI.parse(URI.escape(messages.first.filepath))}")
    end

    def template
      File.read(File.expand_path("../message.html.erb", __FILE__))
    end

    def rendered_file
      ERB.new(template).result(binding)
    end
  end
end

require 'erb'
require 'launchy'

module NotificationsOpener
  class Message
    attr_accessor :config,
                  :from,
                  :to,
                  :message,
                  :location

    def initialize(config)
      @config = config
      @from = config[:from]
      @to = config[:to]
      @message = config[:message]

      @location = config[:location]
    end

    def deliver
      path = get_file_path
      File.open(path, 'w') { | file | file.write(rendered_content) }
      Launchy.open("file:///#{URI.parse(path)}")
    end

    def template
      File.read(File.expand_path("../message.html.erb", __FILE__))
    end

    def rendered_content
      ERB.new(template).result(binding)
    end

    def get_file_path
      location + '/' + SecureRandom.hex + '.html'
    end
  end
end

require 'erb'
require 'launchy'

module NotificationsOpener
  class Message
    attr_accessor :config,
                  :from,
                  :to,
                  :message,
                  :location,
                  :file_path

    def initialize(config)
      @config = config
      @from = config[:from]
      @to = config[:to]
      @message = config[:message]

      @location = config[:location]
      @file_path = get_file_path
    end

    def deliver
      File.open(file_path, 'w') { | file | file.write(rendered_content) }
      Launchy.open("file:///#{URI.parse(file_path)}")
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

##
# This class represents builds a usable message based on the parameters

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

    # #
    # Creates the file with the interpolated content in the specified location
    # Opens it up in a browser from preview
    def deliver
      File.open(file_path, 'w') { | file | file.write(rendered_content) }
      Launchy.open("file:///#{URI.parse(file_path)}")
    end

    # #
    # Uses the message template and binds the instance variable to the template
    # to generate the final markup
    def rendered_content
      ERB.new(template).result(binding)
    end

    def template
      File.read(File.expand_path("../message.html.erb", __FILE__))
    end
    
    def get_file_path
      location + '/' + SecureRandom.hex + '.html'
    end
  end
end

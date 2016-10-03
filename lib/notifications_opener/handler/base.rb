require 'erb'
require 'launchy'

module NotificationsOpener
  module Handler
    class Base
      attr_accessor :config,
                    :env,
                    :file_path

      def initialize(config, env)
        @config = config
        @env = env
        @file_path = generate_file_path
        @notification_type = notification_type.capitalize
      end

      # #
      # Creates the file with the interpolated content in the specified location
      # Opens it up in a browser from preview
      def deliver
        File.open(file_path, 'w') { |file| file.write(rendered_content) }
        Launchy.open("file:///#{URI.parse(file_path)}")
      end

      # #
      # Uses the message template and binds the instance variable to the template
      # to generate the final markup
      def rendered_content
        ERB.new(template).result(binding)
      end

      def template
        File.read(File.expand_path("../../template/#{notification_type}.html.erb", __FILE__))
      end

      def generate_file_path
        config[:location] + '/' + SecureRandom.hex + '.html'
      end

      def notification_type
        raise NotImplementedError
      end
    end
  end
end

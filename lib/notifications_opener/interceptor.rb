require 'webmock'
require 'rack'

##
# On requiring webmock it disables HTTP connections by default
# so we need to call this method after requiring it, since we only
# want stub the url that has been passed in the configuration

module NotificationsOpener
  ##
  # This class represents as an interceptor for the HTTP requests to the
  # specified URL
  class Interceptor
    include WebMock::API
    WebMock.enable!
    WebMock.allow_net_connect!

    attr_accessor :config,
                  :response_handler,
                  :type

    def initialize(config, type)
      @config = config
      @type = type
      @response_handler = ResponseHandler.new(config, type)
    end

    ##
    # Stubs all HTTP requests to the specified URL
    # We also need to process the response to figure
    # out the sender, receiver and the message so we
    # pass it on a rack application
    def intercept_and_redirect_to_rack_app
      stub_request(:any, config[:url]).to_rack(response_handler)
    end
  end
end

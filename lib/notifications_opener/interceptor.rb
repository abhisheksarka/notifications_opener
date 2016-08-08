require 'webmock'
require 'rack'
##
# On requiring webmock it disables HTTP connections by default
# so we need to call this method after requiring it, since we only
# want stub the url that has been passed in the configuration
WebMock.allow_net_connect!

module NotificationsOpener
  ##
  # This class represents as an interceptor for the HTTP requests to the
  # specified URL
  class Interceptor
    attr_accessor :config,
                  :response_handler

    def initialize(config)
      @config = config
      @response_handler = ResponseHandler.new(config)
    end

    ##
    # Stubs all HTTP requests to the specified URL
    # We also need to process the response to figure
    # out the sender, receiver and the message so we
    # pass it on a rack application
    def intercept_and_redirect_to_rack_app
      WebMock.stub_request(:any, config[:url]).to_rack(response_handler)
    end
  end
end

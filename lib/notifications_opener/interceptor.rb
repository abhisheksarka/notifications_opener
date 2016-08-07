require 'webmock'
require 'rack'


# On requiring webmock it disables HTTP connections by default
# so we need to call this method after requiring it
WebMock.allow_net_connect!

module NotificationsOpener
  class Interceptor
    attr_accessor :config,
                  :response_handler

    def initialize(config)
      @config = config
      @response_handler = ResponseHandler.new(config)
      intercept_and_redirect_to_rack_app
    end

    def intercept_and_redirect_to_rack_app
      WebMock.stub_request(:any, config[:url]).to_rack(response_handler)
    end
  end
end

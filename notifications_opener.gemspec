# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notifications_opener/version'

Gem::Specification.new do |spec|
  spec.name          = "notifications_opener"
  spec.version       = NotificationsOpener::VERSION
  spec.authors       = ["abhisheksarka"]
  spec.email         = ["abhisheksarka@gmail.com"]

  spec.summary       = %q{Preview notifications/SMS in browser instead of sending.}
  spec.description   = %q{When notifications are sent from your application, Notifications Opener Opener will open a preview in the browser instead of sending}
  spec.homepage      = "https://github.com/abhisheksarka/notifications_opener"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'httparty'

  spec.add_dependency 'webmock', '>= 2.1'
  spec.add_dependency 'rack'
  spec.add_dependency 'launchy', '~> 2.2'
end

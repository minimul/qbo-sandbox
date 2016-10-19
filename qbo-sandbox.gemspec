# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qbo/sandbox/version'

Gem::Specification.new do |spec|
  spec.name          = "qbo-sandbox"
  spec.version       = Qbo::Sandbox::VERSION
  spec.authors       = ["Christian Pelczarski"]
  spec.email         = ["christian@minimul.com"]

  spec.summary       = %q{Copy production QuickBooks Online resources to a sandbox}
  spec.homepage      = "https://github.com/minimul/qbo-sandbox"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.0"
  spec.add_development_dependency "awesome_print"
  spec.add_runtime_dependency "dotenv"
  spec.add_runtime_dependency "qbo_api"
end

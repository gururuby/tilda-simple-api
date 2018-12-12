lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tilda/simple/api/version"

Gem::Specification.new do |spec|
  spec.name          = "tilda-simple-api"
  spec.version       = Tilda::Simple::Api::VERSION
  spec.authors       = ["V. Miroshnichenko"]
  spec.email         = ["i@gururuby.ru"]

  spec.summary       = %q{Tilda API ruby wrapper}
  spec.description   = %q{Simple ruby wrapper for Tilda API}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", '~> 0.61.0'
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency 'simplecov'

  spec.add_runtime_dependency "httparty"
end

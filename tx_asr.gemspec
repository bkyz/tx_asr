require_relative "lib/tx_asr/version"

Gem::Specification.new do |spec|
  spec.name        = "tx_asr"
  spec.version     = TxAsr::VERSION
  spec.authors     = ["ian"]
  spec.email       = ["ianlynxk@gmail.com"]
  spec.homepage    = "https://github.com/bkyz/tx_asr"
  spec.summary     = "for development app with tencent cloud ASR(Automatic Speech Recognition)"
  spec.description = spec.summary
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
end

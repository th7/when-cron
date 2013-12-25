# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "when-cron"
  spec.version       = '0.0.1'
  spec.authors       = ["TH"]
  spec.email         = ["tylerhartland7@gmail.com"]
  spec.description   = %q{A basic cron implementation.}
  spec.summary       = %q{A basic cron implementation.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end

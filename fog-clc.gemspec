# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fog-clc"
  spec.version       = "0.1"
  spec.authors       = ["Albert Choi"]
  spec.email         = ["albert.choi@ctl.io"]
  spec.description   = %q{CenturyLinkCloud Fog provider}
  spec.summary       = %q{CenturyLinkCloud Fog provider}
  spec.homepage      = "https://github.com/CenturyLinkCloud/fog-clc"
  spec.license       = "Apache2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency('fog', '>= 1.8')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "shindo"
  spec.add_development_dependency "byebug"
end

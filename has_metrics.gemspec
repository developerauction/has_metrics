# -*- encoding: utf-8 -*-
require File.expand_path('../lib/has_metrics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Allan Grant"]
  gem.email         = ["allan@allangrant.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "has_metrics"
  gem.require_paths = ["lib"]
  gem.version       = HasMetrics::VERSION
end

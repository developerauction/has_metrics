# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "has_metrics"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Allan Grant"]
  s.date = "2013-08-12"
  s.description = "Calculate metrics and store them in the DB."
  s.email = ["allan@allangrant.net"]
  s.files = [".gitignore", "Gemfile", "LICENSE", "README.md", "Rakefile", "has_metrics.gemspec", "lib/has_metrics.rb", "lib/has_metrics/metrics.rb", "lib/has_metrics/segmentation.rb", "lib/has_metrics/sql_capturer.rb", "lib/has_metrics/version.rb", "spec/metrics_spec.rb", "spec/segmentation_spec.rb", "spec/spec_helper.rb", "spec/support/active_record.rb"]
  s.homepage = "http://github.com/allangrant/has_metrics"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Calculate \"metrics\" (any expensive methods) on ActiveRecord entries and memoize them to an automagical table."
  s.test_files = ["spec/metrics_spec.rb", "spec/segmentation_spec.rb", "spec/spec_helper.rb", "spec/support/active_record.rb"]

  s.add_dependency "activerecord"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
end

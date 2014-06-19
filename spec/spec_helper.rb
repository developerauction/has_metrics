require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'active_record'
require 'support/active_record'
require 'has_metrics'

RAILS_4_OR_GREATER = ::ActiveRecord.respond_to?(:version) && ::ActiveRecord.version >= Gem::Version.new('4.0.0')

ActiveRecord::Base.default_timezone = :local

RSpec.configure do |config|
  # some (optional) config here
end

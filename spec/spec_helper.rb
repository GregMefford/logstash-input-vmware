# encoding: utf-8
require 'rspec/given'
require 'webmock/rspec'
require 'logstash-fakes'

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

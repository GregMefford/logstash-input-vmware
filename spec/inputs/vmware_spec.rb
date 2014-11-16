# encoding: utf-8
require "spec_helper"
require "logstash/inputs/vmware"

describe 'inputs/vmware' do
  context "Connecting to an ESXi 5.5 host using unvalidated HTTPS", :vcr do
    # NOTE: If VCR doesn't already have a cassette for the test you're running,
    # you'll need to have a HOSTS file entry or DNS record to point the hostname
    # 'esxi-5-5' to a VMware host running ESXi 5.5.
    Given(:plugin) { LogStash::Inputs::VMware.new(
      "host"     => 'esxi-5-5',
      "username" => 'metrics',
      "password" => 'password',
      "insecure" => true,
    )}
    Then{ expect{ plugin.register }.to_not raise_error }
  end
end

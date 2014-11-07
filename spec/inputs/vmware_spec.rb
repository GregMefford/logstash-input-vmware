# encoding: utf-8
require "spec_helper"
require "logstash/inputs/vmware"

describe 'inputs/vmware' do
  context "Connecting to an ESXi host using unvalidated HTTPS", :vcr do
    Given(:plugin) { LogStash::Inputs::VMware.new(
      "host" => 'esxi_5_5',
      "user" => 'metrics',
      "password" => 'metrics',
      "insecure" => true,
    )}
    Then{ expect{ plugin.register }.to_not raise_error }
  end
end

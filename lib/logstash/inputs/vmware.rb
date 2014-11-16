# encoding: utf-8
require "logstash/inputs/base"

# This input collects information from a VMware ESXi hosts or vCenter Servers.
#
# It is still a work-in-progress, but the intent is that it would support
# collecting performance metrics as well as events and alerts.
#
# This input relies on the rbvmomi gem <https://github.com/vmware/rbvmomi>
# which provides Ruby bindings to VMware's
# VSphere Web Services SDK <https://www.vmware.com/support/developer/vc-sdk/>.
#
class LogStash::Inputs::VMware < LogStash::Inputs::Base
  config_name "vmware"
  milestone 1

  # The hostname or IP address of the ESXi host or vCenter server.
  config :host, :validate => :string, :default => "127.0.0.1"

  # The port to connect on.
  config :port, :validate => :number, :default => 443

  # Whether to use HTTPS (as opposed to HTTP).
  config :https, :validate => :boolean, :default => true

  # Set to true to ignore invalid (e.g. self-signed) certificates.
  config :insecure, :validate => :boolean, :default => false

  # Username to authenticate with. This will be used to connect to the ESXi host
  # or vCenter server and must have appropriate permissions to read the
  # information you're trying to collect with this plugin.
  config :username, :validate => :string, :required => true

  # Password to authenticate with.
  config :password, :validate => :password, :required => true

  public
  def register
    require 'rbvmomi'
    logger.info("Registering VMware Input", :host => @host, :port => @port)
  end # def register

  private
  def connection
    @connection ||= RbVmomi::VIM.connect(
      :host => @host,
      :port => @port,
      :ssl => @https,
      :insecure => @insecure,
      :user => @username,
      :password => @password,
    )
  end # def connection

  public
  def run(output_queue)
    logger.info("VMware Input entering run loop", :host => @host, :port => @port)
    loop do
      # TBD
      sleep 1
    end
  end # def run

  public
  def teardown
    logger.info("Tearing-Down VMware Input", :host => @host, :port => @port)
    connection.close
  end #def teardown
end # class LogStash::Inputs::VMware

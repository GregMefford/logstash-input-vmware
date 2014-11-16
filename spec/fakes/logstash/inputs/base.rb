# encoding: utf-8

require 'logstash/config/mixin'

class LogStash::Inputs::Base
  include LogStash::Config::Mixin
  attr_accessor :logger

  public
  def initialize(params={})
    config_init(params)
    @logger = Object.new
    def @logger.method_missing(meth, *args, &block) end
  end # def initialize
end

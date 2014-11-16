# encoding: utf-8

module LogStash::Config::Mixin
  # This method is called when someone does 'include LogStash::Config'
  def self.included(base)
    # Add the DSL methods to the 'base' given.
    base.extend(LogStash::Config::Mixin::DSL)
  end

  def config_init(params)
    # Set defaults from 'config :foo, :default => somevalue'
    params = Hash.new
    self.class.get_config.each do |name, opts|
      if opts.include?(:default)
        # Clone the default values if possible
        case opts[:default]
          when FalseClass, TrueClass, NilClass, Numeric
            params[name] = opts[:default]
          else
            params[name] = opts[:default].clone
        end
      end
    end
    params.merge!(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @config = params
  end # def config_init

  module DSL
    def config(name, opts={})
      name = name.to_s
      @config ||= Hash.new
      @config[name] = opts
      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") { |v| instance_variable_set("@#{name}", v) }
      instance_variable_set("@#{name}", opts[:default]) if opts[:default]
    end

    def get_config
      return @config
    end

    def config_name(name)
      fail "config_name must be a String" unless name.is_a? String
    end

    def milestone(number)
      fail "milestone must be a 0 to 3 (inclusive)" unless (0..3) === number
    end
  end
end

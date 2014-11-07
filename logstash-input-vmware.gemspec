Gem::Specification.new do |s|

  s.name            = 'logstash-input-vmware'
  s.version         = '0.1.0'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "This input collects information from a VMware ESXi host or vCenter Server."
  s.description     = "This input collects information from a VMware ESXi host or vCenter Server. It is still a work-in-progress, but the intent is that it would support collecting performance metrics as well as events and alerts."
  s.authors         = ["Greg Mefford"]
  s.email           = 'greg@gregmefford.com'
  s.homepage        = "http://www.gregmefford.com/"
  s.require_paths = ["lib"]

  # Files
  s.files = `git ls-files`.split($\)+::Dir.glob('vendor/*')

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency 'logstash', '>= 1.4.0', '< 2.0.0'

  s.add_runtime_dependency 'rbvmomi'

end

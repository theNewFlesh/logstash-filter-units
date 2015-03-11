Gem::Specification.new do |s|

	s.name            = 'logstash-filter-units'
	s.version         = '0.1.0'
	s.licenses        = ['Apache License (2.0)']
	s.summary         = "A filter for performing unit conversions on specified fields."
	s.description     = "The units filter is used for converting specified fields from one unit of measure to another (or many others)."
	s.authors         = ["Alex Braun"]
	s.email           = 'ABraunCCS@gmail.com'
	s.homepage        = "http://www.elasticsearch.org/guide/en/logstash/current/index.html"
	s.require_paths   = ["lib"]

	# Files
	s.files = `git ls-files`.split($\)

	# Tests
	s.test_files = s.files.grep(%r{^(test|spec|features)/})

	# Special flag to let us know this is actually a logstash plugin
	s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

	# Gem dependencies
	s.add_runtime_dependency "logstash", '>= 1.4.0', '< 2.0.0'
	s.add_development_dependency 'logstash-devutils'
	s.add_runtime_dependency "unitwise", ">= 1.0.4"
end

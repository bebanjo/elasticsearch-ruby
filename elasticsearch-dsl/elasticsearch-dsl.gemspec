# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch/dsl/version'

Gem::Specification.new do |s|
  s.name          = 'elasticsearch-dsl'
  s.version       = Elasticsearch::DSL::VERSION
  s.authors       = ['Karel Minarik']
  s.email         = ['karel.minarik@elasticsearch.com']
  s.description   = %q{A Ruby DSL builder for Elasticsearch}
  s.summary       = s.description
  s.homepage      = 'https://www.elastic.co/guide/en/elasticsearch/client/ruby-api/current/index.html'
  s.license       = 'Apache-2.0'
  s.metadata = {
    'homepage_uri' => 'https://www.elastic.co/guide/en/elasticsearch/client/ruby-api/current/index.html',
    'changelog_uri' => 'https://github.com/elastic/elasticsearch-ruby/blob/6.x/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/elastic/elasticsearch-ruby/tree/6.x/elasticsearch-dsl',
    'bug_tracker_uri' => 'https://github.com/elastic/elasticsearch-ruby/issues'
  }
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.extra_rdoc_files  = ['README.md', 'LICENSE.txt']
  s.rdoc_options      = ['--charset=UTF-8']

  s.required_ruby_version = '>= 1.9'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'elasticsearch'
  s.add_development_dependency 'elasticsearch-extensions'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake', '~> 13'
  s.add_development_dependency 'shoulda-context'
  s.add_development_dependency 'simplecov', '~> 0.17', '< 0.18'
  s.add_development_dependency 'test-unit', '~> 2'
  s.add_development_dependency 'yard'
end

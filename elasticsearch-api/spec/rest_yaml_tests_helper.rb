# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require "#{File.expand_path(File.dirname('..'), '..')}/api-spec-testing/test_file"
require "#{File.expand_path(File.dirname('..'), '..')}/api-spec-testing/rspec_matchers"
include Elasticsearch::RestAPIYAMLTests

TRANSPORT_OPTIONS = {}
PROJECT_PATH = File.join(File.dirname(__FILE__), '..', '..')

if (hosts = ELASTICSEARCH_URL)
  split_hosts = hosts.split(',').map do |host|
    /(http\:\/\/)?\S+/.match(host)
  end
  uri = URI.parse(split_hosts.first[0])
  TEST_HOST = uri.host
  TEST_PORT = uri.port
else
  TEST_HOST, TEST_PORT = 'localhost', '9200'
end

if defined?(TEST_HOST) && defined?(TEST_PORT)
  URL = "http://#{TEST_HOST}:#{TEST_PORT}"

  ADMIN_CLIENT = Elasticsearch::Client.new(host: URL, transport_options: TRANSPORT_OPTIONS)

  if ENV['QUIET'] == 'true'
    DEFAULT_CLIENT = Elasticsearch::Client.new(host: URL, transport_options: TRANSPORT_OPTIONS)
  else
    DEFAULT_CLIENT = Elasticsearch::Client.new(host: URL,
                                               transport_options: TRANSPORT_OPTIONS,
                                               tracer: Logger.new($stdout))
  end
end

YAML_FILES_DIRECTORY = "#{File.expand_path(File.dirname('..'), '..')}" +
                       '/tmp/elasticsearch/rest-api-spec/src/main/resources/rest-api-spec/test'

SINGLE_TEST = if ENV['SINGLE_TEST'] && !ENV['SINGLE_TEST'].empty?
                test_target = ENV['SINGLE_TEST']
                path = File.expand_path(File.dirname('..'), '..')

                if test_target.match?(/\.yml$/)
                  ["#{path}/tmp/elasticsearch/rest-api-spec/src/main/resources/rest-api-spec/test/#{test_target}"]
                else
                  Dir.glob(
                    ["#{path}/tmp/elasticsearch/rest-api-spec/src/main/resources/rest-api-spec/test/#{test_target}/*.yml"]
                  )
                end
              end

skipped_tests = []

# Response from Elasticsearch is just a String, so it's not possible to compare using headers.
skipped_tests << { file:        'cat.aliases/20_headers.yml',
                   description: 'Simple alias with yaml body through Accept header' }

# Check version skip logic
skipped_tests << { file:        'create/15_without_id.yml',
                   description: 'Create without ID' }

# Error message doesn't match
skipped_tests << { file:        'tasks.get/10_basic.yml',
                   description: 'get task test' }

# Figure out how to match response when there is an error
skipped_tests << { file:        'cat.templates/10_basic.yml',
                   description: '*' }

# TODO
skipped_tests << { file: 'indices.resolve_index/10_basic_resolve_index.yml',
                   description: 'Resolve index with hidden and closed indices' }

SKIPPED_TESTS = skipped_tests

# The directory of rest api YAML files.
REST_API_YAML_FILES = SINGLE_TEST || Dir.glob("#{YAML_FILES_DIRECTORY}/**/*.yml")

# The features to skip
REST_API_YAML_SKIP_FEATURES = ['warnings', 'node_selector'].freeze

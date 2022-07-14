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

# 'catch' is in the task group definition
def run_rspec_matchers_on_task_group(task_group, test)
  if task_group.catch_exception?
    it 'sends the request and throws the expected error' do
      expect(task_group.exception).to match_error(task_group.expected_exception_message)
    end

    # 'match' on error description is in the task group definition
    if task_group.has_match_clauses?
      task_group.match_clauses.each do |match|
        it 'contains the expected error in the request response' do
          regexp = if (val = match['match'].values.first.to_s).include?('\\s')
                     Regexp.new(val.gsub('\\\\', '\\').gsub('/', ''))
                   else
                     Regexp.new(Regexp.escape(val))
                   end
          expect(task_group.exception.message).to match(regexp)
        end
      end
    end
  else
    # 'match' is in the task group definition
    if task_group.has_match_clauses?
      task_group.match_clauses.each do |match|
        it "has the expected value (#{match['match'].values.join(',')}) in the response field (#{match['match'].keys.join(',')})" do
          expect(task_group.response).to match_response(match['match'], test)
        end
      end
    end

    # 'length' is in the task group definition
    if task_group.has_length_match_clauses?
      task_group.length_match_clauses.each do |match|
        it "the '#{match['length'].keys.join(',')}' field have the expected length" do
          expect(task_group.response).to match_response_field_length(match['length'], test)
        end
      end
    end

    # 'is_true' is in the task group definition
    if task_group.has_true_clauses?
      task_group.true_clauses.each do |match|
        it "sends the request and the '#{match['is_true']}' field is set to true" do
          expect(task_group.response).to match_true_field(match['is_true'], test)
        end
      end
    end

    # 'is_false' is in the task group definition
    if task_group.has_false_clauses?
      task_group.false_clauses.each do |match|
        it "sends the request and the '#{match['is_false']}' field is set to true" do
          expect(task_group.response).to match_false_field(match['is_false'], test)
        end
      end
    end

    # 'gte' is in the task group definition
    if task_group.has_gte_clauses?
      task_group.gte_clauses.each do |match|
        it "sends the request and the '#{match['gte']}' field is greater than or equal to the expected value" do
          expect(task_group.response).to match_gte_field(match['gte'], test)
        end
      end
    end

    # 'gt' is in the task group definition
    if task_group.has_gt_clauses?
      task_group.gt_clauses.each do |match|
        it "sends the request and the '#{match['gt']}' field is greater than the expected value" do
          expect(task_group.response).to match_gt_field(match['gt'], test)
        end
      end
    end

    # 'lte' is in the task group definition
    if task_group.has_lte_clauses?
      task_group.lte_clauses.each do |match|
        it "sends the request and the '#{match['lte']}' field is less than or equal to the expected value" do
          expect(task_group.response).to match_lte_field(match['lte'], test)
        end
      end
    end

    # 'lt' is in the task group definition
    if task_group.has_lt_clauses?
      task_group.lt_clauses.each do |match|
        it "sends the request and the '#{match['lt']}' field is less than the expected value" do
          expect(task_group.response).to match_lt_field(match['lt'], test)
        end
      end
    end
  end
end

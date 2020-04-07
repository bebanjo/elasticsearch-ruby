# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

require 'spec_helper'

describe 'client.cluster#put_settings' do

  let(:expected_args) do
    [
        'PUT',
        '_cluster/settings',
        {},
        {},
        {}
    ]
  end

  it 'performs the request' do
    expect(client_double.cluster.put_settings(body: {})).to eq({})
  end
end

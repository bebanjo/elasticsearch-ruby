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
#
# Auto generated from commit f284cc16f4d4b4289bc679aa1529bb504190fe80
# @see https://github.com/elastic/elasticsearch-specification
#
module Elasticsearch
  module API
    module Security
      module Actions
        # Logout of SAML completely.
        # Verifies the logout response sent from the SAML IdP.
        # NOTE: This API is intended for use by custom web applications other than Kibana.
        # If you are using Kibana, refer to the documentation for configuring SAML single-sign-on on the Elastic Stack.
        # The SAML IdP may send a logout response back to the SP after handling the SP-initiated SAML Single Logout.
        # This API verifies the response by ensuring the content is relevant and validating its signature.
        # An empty response is returned if the verification process is successful.
        # The response can be sent by the IdP with either the HTTP-Redirect or the HTTP-Post binding.
        # The caller of this API must prepare the request accordingly so that this API can handle either of them.
        #
        # @option arguments [Hash] :headers Custom HTTP headers
        # @option arguments [Hash] :body request body
        #
        # @see https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-security-saml-complete-logout
        #
        def saml_complete_logout(arguments = {})
          request_opts = { endpoint: arguments[:endpoint] || 'security.saml_complete_logout' }

          raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

          arguments = arguments.clone
          headers = arguments.delete(:headers) || {}

          body = arguments.delete(:body)

          method = Elasticsearch::API::HTTP_POST
          path   = '_security/saml/complete_logout'
          params = {}

          Elasticsearch::API::Response.new(
            perform_request(method, path, params, body, headers, request_opts)
          )
        end
      end
    end
  end
end

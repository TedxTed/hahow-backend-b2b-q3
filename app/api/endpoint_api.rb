require 'grape-swagger'

class EndpointApi < Grape::API
  PREFIX = '/api'

  mount V1::Root
end

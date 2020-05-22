require 'swagger_helper'

describe 'Store' do


  path '/v1/store' do
    post 'Create a store' do
      tags 'Products'
      description 'Create a new store'
      consumes 'application/json'
      produces 'application/json'

    end
  end
end

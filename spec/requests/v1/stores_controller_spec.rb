require 'swagger_helper'

describe 'Store' do


  path '/v1/stores' do

    post 'Create a store' do
      tags 'Stores'
      description 'Create a new store'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :store, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              address: { type: :string }
          },
          required: [ 'name', 'address']
      }


      response '200', 'store created' do
        let(:store) { { name: 'foo', address: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:store) { { name: 'foo' } }
        run_test!
      end
    end
  end


  path '/v1/stores/{id}' do

    put 'Update a store' do
      tags 'Stores'
      description 'Update a store'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number
      parameter name: :store, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              address: { type: :string }
          },
          required: [ 'name', 'address' ]
      }


      response '200', 'store updated' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   address: { type: :string }
               },
               required: [ 'id', 'name', 'address' ]

        let(:store) { create(:store) }
        let(:id) { store.id }
        run_test!
      end

      response '404', 'Store not found' do
        let(:store) { create(:store) }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/stores/{id}' do

    get 'Retrieve a stores' do
      tags 'Stores'
      description 'Retrieve a store'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '200', 'Store found' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   address: { type: :string }
               },
               required: [ 'id', 'name', 'address' ]

        let(:id) { create(:store).id }
        run_test!
      end

      response '404', 'Store not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/stores/{id}' do
    delete 'Delete a store' do
      tags 'Stores'
      description 'Delete a store'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '204', 'store deleted' do
        let(:id) { create(:store).id }
        run_test!
      end

      response '404', 'Store not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

end

require 'swagger_helper'

describe 'Products' do

  path '/v1/products' do

    post 'Creates a Product' do
      tags 'Products'
      description 'Create a new product'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              manufactory: { type: :string },
              cost_price: { type: :number }
          },
          required: [ 'name', 'manufactory', 'cost_price' ]
      }

      response '200', 'product created' do
        let(:product) { { name: 'foo', manufactory: 'bar', cost_price: 10.00 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/v1/products/{id}' do

    put 'Update a product' do
      tags 'Products'
      description 'Update a product'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number
      parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              manufactory: { type: :string },
              cost_price: { type: :number }
          },
          required: [ 'name', 'manufactory', 'cost_price' ]
      }


      response '200', 'product updated' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   manufactory: { type: :string },
                   cost_price: { type: :number }

               },
               required: [ 'id', 'name', 'manufactory',  'cost_price' ]

        let(:product) { create(:product) }
        let(:id) { product.id }
        run_test!
      end

      response '404', 'Product not found' do
        let(:product) { create(:product) }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/products/{id}' do
    get 'Retrieve a product' do
      tags 'Products'
      description 'Retrieve a product'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number


      response '200', 'product found' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   manufactory: { type: :string },
                   cost_price: { type: :number }

               },
               required: [ 'id', 'name', 'manufactory',  'cost_price' ]

        let(:id) { create(:product).id }
        run_test!
      end

      response '404', 'Product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/products/{id}' do
    delete 'Delete a product' do
      tags 'Products'
      description 'Delete a product'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '204', 'product deleted' do
        let(:id) { create(:product).id }
        run_test!
      end

      response '404', 'Product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
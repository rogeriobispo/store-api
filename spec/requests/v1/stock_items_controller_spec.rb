require 'swagger_helper'

describe 'Stock Item' do

  path '/v1/stock_items' do

    post 'Create a product at a store' do
      tags 'StockItem'
      description 'Add item at a store stock'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :stock_item, in: :body, schema: {
          type: :object,
          properties: {
              product_id: { type: :number },
              store_id: { type: :number },
              quantity: { type: :number }
          },
          required: [ 'product_id', 'store_id', 'quantity']
      }


      response '200', 'Item add to store stock' do
        let(:stock_item) { { product_id: create(:product).id, store_id: create(:store).id, quantity: 0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:stock_item) { { product_id: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:stock_item2){ create(:stock_item) }
        let(:stock_item) { { product_id: stock_item2.product.id, store_id: stock_item2.store.id, quantity: 0 } }
        run_test!
      end
    end
  end


  path '/v1/stock_items' do

    patch 'Increase stock_item' do
      tags 'StockItem'
      description 'Increases a existing item on stock'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :stock_item, in: :body, schema: {
          type: :object,
          properties: {
              product_id: { type: :number },
              store_id: { type: :number },
              quantity: { type: :number }
          },
          required: [ 'product_id', 'store_id', 'quantity']
      }


      response '200', 'Increase stocke item' do
        let(:stock_to_update) { create(:stock_item) }
        let(:stock_item) { { product_id: stock_to_update.product.id, store_id: stock_to_update.store.id,  quantity: 10 } }
        run_test!
      end

      response '404', 'invalid request' do
        let(:stock_item) { { product_id: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        negative_quantity = -10
        let(:stock_item2){ create(:stock_item) }
        let(:stock_item) { { product_id: stock_item2.product.id, store_id: stock_item2.store.id, quantity: negative_quantity  } }
        run_test!
      end
    end
  end


  path '/v1/stock_items' do

    delete 'Decrease stock_item' do
      tags 'StockItem'
      description 'Decrease a existing item on stock'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :stock_item, in: :body, schema: {
          type: :object,
          properties: {
              product_id: { type: :number },
              store_id: { type: :number },
              quantity: { type: :number }
          },
          required: [ 'product_id', 'store_id', 'quantity']
      }


      response '200', 'decrease stock item' do
        let(:stock_to_decrease) { create(:stock_item, quantity: 10) }
        let(:stock_item) { { product_id: stock_to_decrease.product.id, store_id: stock_to_decrease.store.id, quantity: 10 } }
        run_test!
      end

      response '404', 'invalid request' do
        let(:stock_item) { { product_id: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        negative_quantity = -10
        let(:stock_item2){ create(:stock_item) }
        let(:stock_item) { { product_id: stock_item2.product.id, store_id: stock_item2.store.id, quantity: negative_quantity  } }
        run_test!
      end
    end
  end

end
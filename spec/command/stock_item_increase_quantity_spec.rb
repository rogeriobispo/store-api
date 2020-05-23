require 'rails_helper'

RSpec.describe StockItemIncreseQuantity, type: :model do
  describe 'should increase a stock item' do
    it 'when the value is correct(positive number)' do
      stock_item = create(:stock_item)
      quantity_before_increase = stock_item.quantity
      quantity = 5;

      stock_item_increased = StockItemIncreseQuantity.execute(stock_item.id, quantity)

      expect(stock_item_increased.quantity).not_to eq(quantity_before_increase)
      expect(stock_item_increased.quantity).to eq(quantity_before_increase + quantity)
    end

    it 'when the value is zero must keep last quantity' do

      stock_item = create(:stock_item, quantity: 10)
      quantity_before_increase = stock_item.quantity
      quantity = 0

      stock_item_increased = StockItemIncreseQuantity.execute(stock_item.id, quantity)

      expect(stock_item_increased.quantity).to eq(quantity_before_increase)
      expect(stock_item_increased.quantity).to eq(stock_item.quantity)
    end

    it 'must reject negative values' do

      stock_item = create(:stock_item, quantity: 10)
      quantity_before_increase = stock_item.quantity
      quantity = -1

      expect{
       StockItemIncreseQuantity.execute(stock_item.id, quantity)
      }.to raise_error(ValidationException, "Quantity must be a positive Number")

    end


    it 'shoud increase right in a racecondition' do
      stock_item = create(:stock_item, quantity: 0)
      quantity = 1

      # this treed will lock the register.
      thread = Thread.new do
        3.times do
          StockItemIncreseQuantity.execute(stock_item.id, quantity) do
            puts "with sleep"
            sleep 5
          end
        end
      end

      # this trhead will execute with the first thread concurring
     thread2 = Thread.new do
        2.times do
          StockItemIncreseQuantity.execute(stock_item.id, quantity) do
            puts "without sleep"
          end
        end
     end

      thread.join
      thread2.join
      stock_item.reload

      expect(stock_item.quantity).to eq(5)
    end
  end
end
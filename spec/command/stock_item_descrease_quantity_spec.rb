require 'rails_helper'

RSpec.describe StockItemIncreaseQuantity, type: :model do
  describe 'should decrease a stock item' do
    it 'when the value is correct(positive number)' do
      stock_item = create(:stock_item, quantity: 10)
      quantity_before_decreased = stock_item.quantity
      quantity = 5;

      stock_item_decreased = StockItemDecreaseQuantity.execute(stock_item.id, quantity)

      expect(stock_item_decreased.quantity).not_to eq(quantity_before_decreased)
      expect(stock_item_decreased.quantity).to eq(quantity_before_decreased - quantity)
    end
  end

  it 'must not decrease  in a racecondition' do
    stock_item = create(:stock_item, quantity: 4)
    concluded = 0
    quantity = 1

    expect{

      # this treed will lock the register.
      thread = Thread.new do
        6.times do
          StockItemDecreaseQuantity.execute(stock_item.id, quantity) do
            puts "with sleep"
            concluded += 1
            sleep 2
          end
        end
      end

      # this trhead will execute with the first thread concurring
      Thread.new do
        6.times do
          StockItemDecreaseQuantity.execute(stock_item.id, quantity) do
            puts "without"
            concluded += 1
          end
        end
      end
     thread.join
    }.to raise_exception(ValidationException, 'Quantity not enough to this item')

    stock_item.reload

    expect(stock_item.quantity).to eq(0)
    expect(concluded).to eq(4)
  end

  it 'must reject negative values' do
    stock_item = create(:stock_item, quantity: 10)
    quantity_before_decrease = stock_item.quantity
    quantity = -1

    expect{
      StockItemDecreaseQuantity.execute(stock_item.id, quantity)
    }.to raise_exception(ValidationException, "Quantity must be a positive Number")

  end
end


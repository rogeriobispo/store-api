class StockItemDecreaseQuantity
  def self.execute(stock_item_id, quantity)
    StockItem.transaction do
      stock_item = StockItem.find(stock_item_id)
      raise ValidationException.new('Quantity not enough to this item') if stock_item.quantity.to_i < quantity.to_i
      raise ValidationException.new('Quantity must be a positive Number') if quantity.negative?
      stock_item.quantity -= quantity.to_i
      yield if block_given?
      stock_item if stock_item.save
    end
  end
end

class StockItemIncreaseQuantity
  def self.execute(stock_item_id, quantity)
    StockItem.transaction do
      stock_item = StockItem.find(stock_item_id).lock!
      raise ValidationException.new('Quantity must be a positive Number') if !quantity || quantity.negative?
      stock_item.quantity += quantity.to_i
      yield  if block_given?
      stock_item if stock_item.save
    end
  end
end
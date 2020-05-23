FactoryBot.define do
  factory :stock_item do
    product { create(:product) }
    store { create(:store) }
    quantity { 0 }
  end
end

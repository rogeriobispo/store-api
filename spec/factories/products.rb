require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Name.unique }
    manufactory { FFaker::Name.unique }
    cost_price { 100.00 }
  end
end

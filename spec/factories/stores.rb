FactoryBot.define do
  factory :store do
    name { FFaker::Name.unique }
    address { FFaker::Address.unique }
  end
end

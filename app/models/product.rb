class Product < ApplicationRecord
  validates :name, :manufactory, :cost_price, presence: true
  validates :name, uniqueness: true
  acts_as_paranoid
end

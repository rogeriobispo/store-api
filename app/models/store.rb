class Store < ApplicationRecord
  validates :name, :address, presence: true
  validates :name, uniqueness: true
  acts_as_paranoid
end

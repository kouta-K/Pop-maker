class Store < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :maker, presence: true
  validates :category, presence: true
end

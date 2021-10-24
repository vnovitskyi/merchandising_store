class Discount < ApplicationRecord
  DISCOUNT_TYPES = %w[
    Discounts::FreeItem
    Discounts::Percentage
  ].freeze

  has_many :item_discounts
  has_many :items, through: :item_discounts

  validates :type, presence: true, inclusion: {in: DISCOUNT_TYPES}
  validates :purchase_item_quantity, numericality: {greater_than: 0}, allow_nil: true
end

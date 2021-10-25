module Discounts
  class FreeItem < Discount
    validates :free_item_quantity, numericality: {greater_than: 0}, allow_nil: true
  end
end

module DiscountCalculators
  class FreeItem < Base
    def calculate_discount
      discount_items.map do |item, quantity|
        next if quantity < @discount.purchase_item_quantity

        normal_items_price = item.price * quantity
        free_item_quantity = free_item_quantity(quantity)

        (normal_items_price - (item.price * (quantity - free_item_quantity)))
      end.compact.sum
    end

    private

    # how many items should be for free
    def free_item_quantity(quantity)
      (quantity / @discount.purchase_item_quantity) * @discount.free_item_quantity
    end
  end
end

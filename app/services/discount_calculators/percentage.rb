module DiscountCalculators
  class Percentage < Base
    def calculate_discount
      discount_items.map do |item, quantity|
        next if quantity < @discount.purchase_item_quantity

        item.price * quantity * (@discount.percent_discount / 100.00)
      end.compact.sum
    end
  end
end

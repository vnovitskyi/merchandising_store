class ItemsPrice
  class CalculateDiscounts < BaseInteractor
    delegate :grouped_items, to: :input
    delegate :discount, to: :output

    def call
      output.discount = calculate_discounts
    end

    private

    def calculate_discounts
      discounts.sum do |discount|
        DiscountCalculator.new(discount, grouped_items).calculate
      end
    end

    def discounts
      Discount.applicable_for_items(grouped_items.keys)
    end
  end
end

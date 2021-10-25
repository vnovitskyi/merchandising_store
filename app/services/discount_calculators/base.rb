module DiscountCalculators
  class Base
    def initialize(discount, items)
      @discount = discount
      @items = items
    end

    def calculate_discount
      raise NotImplementedError
    end

    private

    # choose only items for appropriate discount
    def discount_items
      @items.select { |item| @discount.items.include?(item) }
    end
  end
end

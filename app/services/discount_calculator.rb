class DiscountCalculator
  def initialize(discount, items)
    @discount = discount
    @items = items
  end

  def calculate
    calculator.calculate_discount
  end

  private

  def calculator
    "DiscountCalculators::#{discount_type}".constantize.new(@discount, @items)
  end

  def discount_type
    @discount.class.name.demodulize
  end
end

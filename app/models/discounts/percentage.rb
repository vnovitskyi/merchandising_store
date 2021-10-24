module Discounts
  class Percentage < Discount
    validates :percent_discount, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  end
end

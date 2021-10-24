class ItemsPrice
  class CalculateNormalPrice < BaseInteractor
    delegate :grouped_items, to: :input
    delegate :normal_price, to: :output

    def call
      output.normal_price = normal_price
    end

    private

    def normal_price
      grouped_items.sum { |item, quantity| item.price * quantity }
    end
  end
end

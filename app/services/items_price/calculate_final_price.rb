class ItemsPrice
  class CalculateFinalPrice < BaseInteractor
    delegate :discount, :normal_price, to: :input
    delegate :data, to: :output

    def call
      output.data = data
    end

    private

    def data
      {
        normal_price: normal_price,
        discount: discount,
        total: total
      }
    end

    def total
      normal_price - discount
    end
  end
end

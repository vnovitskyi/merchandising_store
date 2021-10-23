class UpdateItem < BaseInteractor
  delegate :id, :price, to: :input
  delegate :data, to: :output

  def call
    update_item
    output.data = item.serialize
  end

  private

  def update_item
    item.update!(price: price)
  end

  def item
    Item.find(id)
  end
end

class UpdateItem < BaseInteractor
  delegate :gid, :price, to: :input
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
    Item.find_by!(gid: gid)
  end
end

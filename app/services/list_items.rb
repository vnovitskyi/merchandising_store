class ListItems < BaseInteractor
  delegate :data, to: :output

  def call
    output.data = serialize_items
  end

  private

  def serialize_items
    Item.find_each.each_with_object([]) { |item, arr| arr << item.serialize }
  end
end

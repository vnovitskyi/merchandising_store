class ItemsController < APIController
  def index
    render_context(list_items)
  end

  def update
    render_context(update_item)
  end

  def price
    render_context(items_price)
  end

  private

  def list_items
    ListItems.()
  end

  def update_item
    UpdateItem.(gid: params[:id], price: params[:price])
  end

  def items_price
    ItemsPrice.(codes: params[:codes])
  end
end

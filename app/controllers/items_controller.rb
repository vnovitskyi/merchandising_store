class ItemsController < APIController
  def index
    render_context(list_items)
  end

  def update
    render_context(update_item)
  end

  private

  def list_items
    ListItems.()
  end

  def update_item
    UpdateItem.(id: params[:id], price: params[:price])
  end
end

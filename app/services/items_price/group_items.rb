class ItemsPrice
  class GroupItems < BaseInteractor
    delegate :gids, to: :input
    delegate :grouped_items, to: :output

    def call
      output.grouped_items = group_items
    end

    private

    def group_items
      items = {}
      group_gids.each do |gid, quantity|
        item = Item.find_by!(gid: gid)
        items[item] = quantity
      end
      items
    end

    def group_gids
      gids.group_by(&:itself).transform_values(&:size)
    end
  end
end

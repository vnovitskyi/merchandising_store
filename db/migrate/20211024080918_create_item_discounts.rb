class CreateItemDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :item_discounts do |t|
      t.references :item, index: true
      t.references :discount, index: true
      t.timestamps
    end
  end
end

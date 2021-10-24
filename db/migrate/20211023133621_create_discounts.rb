class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :type, null: false
      t.integer :purchase_item_quantity
      t.integer :free_item_quantity
      t.integer :percent_discount
      t.timestamps
    end
  end
end

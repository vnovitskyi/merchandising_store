class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :code, null: false, unique: true
      t.string :name, null: false
      t.decimal :price, null: false, precision: 5, scale: 2
      t.uuid :gid, default: "gen_random_uuid()", null: false
      t.timestamps
    end
    
    add_index :items, :code, unique: true
  end
end

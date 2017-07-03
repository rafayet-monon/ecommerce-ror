class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :brand_id
      t.integer :category_id
      t.integer :subcategory_id
      t.integer :price_bought
      t.integer :price_sell
      t.text :image

      t.timestamps null: false
    end
  end
end

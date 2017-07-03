class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :brand_name
      t.text :brand_description

      t.timestamps null: false
    end
  end
end

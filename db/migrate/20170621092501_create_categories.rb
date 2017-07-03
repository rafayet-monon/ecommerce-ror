class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_name
      t.text :category_description
      t.references :parent

      t.timestamps null: false
    end
  end
end

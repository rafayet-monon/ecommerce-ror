class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :brand
  belongs_to :category
  belongs_to :subcategory , class_name: 'Category', foreign_key: :subcategory_id
end

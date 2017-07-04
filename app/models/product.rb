class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :brand
  belongs_to :category
  belongs_to :subcategory , class_name: 'Category', foreign_key: :subcategory_id

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base , 'Line item present' )
      return false
    end
  end
end

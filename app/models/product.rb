class Product < ActiveRecord::Base

  MONTH_NAME = ['JAN' , 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']
  mount_uploader :image, ImageUploader
  belongs_to :brand
  belongs_to :category
  belongs_to :subcategory , class_name: 'Category', foreign_key: :subcategory_id

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  def self.get_total_sell(year)

    products= Product.all

    report={}

    products.each do |product|

      monthly_hash={}
      (1..12).each do |month|
        monthly_hash[month]={total_quantity:0 , total_price: 0.0 }
      end

      report[product.id]= monthly_hash

    end

    start_time= Time.new(year)
    end_time =start_time.at_end_of_year
    orders = Order.where(created_at: start_time..end_time)

    orders.each do |order|
      month = order.created_at.month

      line_items= order.line_items

      line_items.each do |item|

        total_price = item.quantity*item.product.price_sell
        report[item.product_id][month][:total_price] +=total_price

        total_quantity = item.quantity
        report[item.product_id][month][:total_quantity] +=total_quantity
      end
    end

    report
  end

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

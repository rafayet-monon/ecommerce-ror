class Category < ActiveRecord::Base
  has_many  :subcategories , :class_name => "Category", :foreign_key => "parent_id", dependent: :destroy
  belongs_to :parent_category, :class_name => "Category"
  has_many :products


  def self.get_total_sell(year)

    categories= Category.all.where(parent_id: nil)
    report={}

    categories.each do |category|
      monthly_hash={}
      (1..12).each do |month|
        monthly_hash[month]= {total_quantity:0 , total_price: 0.0 }
      end
      report[category.id]=monthly_hash
    end


    start_time=Time.new(year)
    end_time= start_time.at_end_of_year

    orders=Order.where(created_at: start_time..end_time)

    orders.each do |order|
      month=order.created_at.month

      lineItems= order.line_items.includes(:product)

      lineItems.each do |item|

        total_price = item.quantity*item.product.price_sell
        report[item.product.category_id][month][:total_price] += total_price

        total_quantity = item.quantity
        report[item.product.category_id][month][:total_quantity] +=total_quantity

      end

    end

    report
  end

  def self.get_total_sell_by_month(year, month, days_of_month)

    categories= Category.all.where(parent_id: nil)

    report={}

    categories.each do |category|

      daily_hash={}
      (1..days_of_month).each do |days|
        daily_hash[days]={total_quantity:0 , total_price: 0.0 }
      end

      report[category.id]= daily_hash

    end

    start_time= Time.new(year ,month)
    end_time =start_time.at_end_of_month
    orders = Order.where(created_at: start_time..end_time)

    orders.each do |order|
      month = order.created_at.day

      line_items= order.line_items.includes(:product)

      line_items.each do |item|

        total_price = item.quantity*item.product.price_sell
        report[item.product.category_id][month][:total_price] +=total_price

        total_quantity = item.quantity
        report[item.product.category_id][month][:total_quantity] +=total_quantity

      end
    end

    report

  end

end


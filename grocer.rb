require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  item_names = []
  cart.each do |item_with_info|
    item_with_info.each do |k, v|
      consolidated_cart[k] = v
      if !item_names.include?(k)
        item_names << k
        consolidated_cart[k][:count] = 1
      elsif item_names.include?(k)
        consolidated_cart[k][:count] += 1
        item_names.include?(k)
      end
    end
  end
  consolidated_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |c|
    if cart[c[:item]] && cart[c[:item]][:count] >= c[:num]
      cart.merge!({"#{c[:item]} W/COUPON" => {:price => c[:cost], :clearance => cart[c[:item]][:clearance], :count => cart[c[:item]][:count] / c[:num]}})
      cart[c[:item]][:count] = cart[c[:item]][:count] % c[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |k, v|
    if cart[k][:clearance] == true
      new_price = cart[k][:price] * 0.80
      cart[k][:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  cart.each do |k, v|
    i_total = v[:price] * v[:count]
    total = total + i_total
  end
  if total > 100
    total = total * 0.90
  end
  total
end

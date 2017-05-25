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

cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}

goal = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
  "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
}

def apply_coupons(cart, coupons)
  coupons.each do |k, v|
    if cart.keys.include?(coupons[:item])
      cart["#{coupons[:item]} W/COUPON"] = {}
      cart["#{coupons[:item]} W/COUPON"][:price] = coupons[:cost]
      cart["#{coupons[:item]} W/COUPON"][:clearance] = cart[coupons[:item]][:clearance]
      cart["#{coupons[:item]} W/COUPON"][:count] = cart[coupons[:item]][:count] % coupons[:num]
      cart[coupons[:item]][:count] = cart[coupons[:item]][:count] % coupons[:num]
    end
  end
  return items
end

def apply_clearance(cart)

end

def checkout(cart, coupons)

end

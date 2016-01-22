class ShippingEstimate
  def self.for order, order_items
    # setup the results hash first
    # result = {"UPS 3Day" => 0, "USPS 2Day" => 0}

    # from order get destination address info
    destination => {:country => order.country, :state => order.state, :city => order.city, :postal_code => order.postal_code}

    # for each user/merchant, make packages
    packages = []
    order_items.group_by { |oi| oi.product.user }.each do |user, oitems|
    # user is the merchant & oitems are all order items from that merchant/user
      # from user/merchant get origin address info
      origin = [user.city, user.state, user.country, user.postal_code]
      # from oitems products get all info for quantity/dimensions
      package_items = []
      oitems.each do |oi|
        p_item = [oi.product.weight, oi.product.height, oi.product.length, oi.product.width]
        package_items << p_item
      end
      packages << [origin, package_items]
    end

    # send HTTParty request to api with above info

    result = HTTParty.get('shippingendpoint.com/something.json',
    body: {params here}.to_json)

    # update the result hash with data recieved from http party / api
    ## result["UPS 3Day"/type] += estimated_cost[ups type]

    return result #= {"UPS 3Day" => 0, "USPS 2Day" => 1}
  end
end

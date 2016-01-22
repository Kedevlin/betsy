class ShippingEstimate
  def self.for order, order_items
    # setup the results hash first
    result = {"UPS 3Day" => 0, "USPS 2Day" => 0}
    # for each vendor, do Http party requests and add the estimate to results
    order_items.group_by { |oi| oi.product.user }.each do |user, oitems|
    # user is the merchant, oitems are all order items for that merchant
      # from order get destination address info
      # from user/merchant get origin address info
      # from oitems products get all info for quantity/dimensions
      # send HTTParty request to api with above info
          # estimated_cost = HTTParty.get.....
      # update the result hash with data recieved from http party / api
          # result["UPS 3Day"] += estimated_cost
    end
    return result = {"UPS 3Day" => 0, "USPS 2Day" => 1}
  end
end

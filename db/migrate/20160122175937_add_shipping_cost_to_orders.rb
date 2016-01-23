class AddShippingCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_cost, :float
  end
end

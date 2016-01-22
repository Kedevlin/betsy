class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user, except: [:new, :create, :confirm, :cancel]

  def index
    orders = @user.orders
    @orders = orders.uniq.sort
    @paid_orders = Order.filter_orders(@orders, "paid")
    @completed_orders = Order.filter_orders(@orders, "shipped")
    @cancelled_orders = Order.filter_orders(@orders, "cancelled")
    @paid_orders_revenue = Order.user_orders_revenue(@paid_orders, @user)
    @completed_orders_revenue = Order.user_orders_revenue(@completed_orders, @user)
    @total_revenue = @paid_orders_revenue + @completed_orders_revenue
    if params["Status"].present?
      @orders = Order.filter_orders(@orders, params["Status"])
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    session[:order_params] ||= {}
    @order = Order.new(session[:order_params])
    @order.current_step = session[:order_step]
    not_enough_stock = false
    @order_items.each do |oi|
      not_enough_stock = true if Product.find(oi.product_id).stock < oi.quantity
    end
    if not_enough_stock
      flash[:error] = "There is not enough stock to complete your purchase. Please update your cart."
      redirect_to cart_path
    else
      @order = Order.new
    end
  end

  def create
    session[:order_params].deep_merge!(order_params) if order_params
    @order = Order.new(session[:order_params])
    @order.current_step = session[:order_step]
    if @order.valid?
      if params[:back_button]
        @order.previous_step
      elsif @order.last_step?
        @order.save if @order.all_valid?
      else
        @order.next_step
      end
      session[:order_step] = @order.current_step
    end
    if @order.new_record?
      render :new
    else
      #Order saved
      products_sold = []
      @order_items.each do |oi|
        @order.order_items << oi
        products_sold.push([oi.product, oi.quantity])
        oi.save
      end
      session[:order_step] = session[:order_params] = nil
      Product.decrement_stock(products_sold)
      session[:cart] = nil
      session[:order_id] = @order.id
      redirect_to confirmation_path
    end
  end

  def confirm
    if session[:order_id].nil?
      flash[:error] = "This page has expired."
      redirect_to root_path
    else
      @order = Order.find(session[:order_id])
      @total = @order.total_cost
    end
  end

  def cancel
    order = Order.find(params[:id])
    order.update(:status => "cancelled")
    Product.increment_stock(order)
    flash[:error] = "Your order has been cancelled"
    redirect_to root_path
  end

  private

  def order_items
    @order_items = []
    session[:cart].each do |product, quantity|
      @order_items.push(OrderItem.new(:product_id => product, :quantity => quantity))
    end
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def order_params
    params.require(:order).permit(:email, :street, :city, :state, :zip, :cc_num, :cc_exp, :cc_cvv, :cc_name, :name)
  end
end

class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = Order.where(customer_id: current_customer.id).order(id: "DESC")
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = CartItem.includes(:item).where(customer_id: current_customer.id)
    @sum = 0
    @cart_items.each do |cart_item|
      @sum += (cart_item.item.price * 1.1).round(0) * cart_item.amount
    end
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = @sum + @order.shipping_cost


    if params[:flag] == "a"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name}#{current_customer.first_name}"
    elsif params[:flag] == "b"
      @address = Address.find(params[:order][:full_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @post = "c"
    end
      render :confirm
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = "waiting"
    @order.save
    if (params[:post]).present?
      @address = Address.new
      @address.customer_id = current_customer.id
      @address.name = @order.name
      @address.postal_code = @order.postal_code
      @address.address = @order.address
      @address.save
    end
    @cart_items = CartItem.includes(:item).where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = "unable"
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to def_path
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end

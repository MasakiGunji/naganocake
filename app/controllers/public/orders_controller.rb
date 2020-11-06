class Public::OrdersController < ApplicationController

  def index
  end

  def complete
  end

  def confirm

    @cart_items = CartItem.includes(:item).where(customer_id: current_customer.id)
    @sum = 0
    @cart_items.each do |cart_item|
      @sum += (cart_item.item.price * 1.1).round(0) * cart_item.amount
    end

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.total_payment = @sum + @order.shipping_cost
    @order.status = "waiting"

    if params[:flag] == "a"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name}#{current_customer.first_name}"
    elsif params[:flag] == "b"
      @address = Address.find(params[:order][:id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
      render :confirm
  end

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = Address.where(customer_id: current_customer.id)
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = CartItem.includes(:item).where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.item.amount
      @order_detail.making_status = 0
      @order_detail.save
    end
    redirect_to def_path
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end

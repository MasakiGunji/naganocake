class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.all.order(id: "DESC")
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.joins(:order_details).find(params[:id])
    @order.update(order_params)
    @order.order_details.each do |order_detail|
      if order_detail.making_status == "unable"
        @order_detail = OrderDetail.find(order_detail.id)
        @order_detail.making_status = "waiting"
        @order_detail.save
      end
      
    end
    redirect_to admins_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end

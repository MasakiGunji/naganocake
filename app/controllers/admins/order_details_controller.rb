class Admins::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = Order.find(@order_detail.order_id)

    count = @order.order_details.count
    sum = 0
    @order.order_details.each do |order_detail|
      if order_detail.making_status == "complete"
        sum += 1
      end
    end

    if count == sum
      @order.status = "ready_to_ship"
      @order.save
    elsif @order_detail.making_status == "making" && @order_detail.order.status != "making"
      @order.status = "making"
      @order.save
    end
    redirect_to admins_order_path(@order_detail.order)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
end

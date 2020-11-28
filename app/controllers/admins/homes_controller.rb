class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
  end
end

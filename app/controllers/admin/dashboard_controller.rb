class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_BASIC_USER'], password: ENV['HTTP_BASIC_PASSWORD']

  def show
    @categories = Category.all
    @products = Product.all
    @orders = Order.all
  end
end

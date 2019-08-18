class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(search_params[:id]))
  end

  def search_params
    params.permit(:id)
  end
end

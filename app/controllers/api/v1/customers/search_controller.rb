class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(search_params.to_h))
  end

  def index
    render json: CustomerSerializer.new(Customer.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end

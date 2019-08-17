class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_by(search_params.to_h))
  end

  def index
    render json: ItemSerializer.new(Item.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end

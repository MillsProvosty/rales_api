class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_by(search_params.to_h))
  end

  def index
    render json: MerchantSerializer.new(Merchant.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end

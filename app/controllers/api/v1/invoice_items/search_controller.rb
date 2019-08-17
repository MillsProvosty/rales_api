class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params.to_h))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
    end
end

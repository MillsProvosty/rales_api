class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params.to_h))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :merchant_id, :customer_id, :status)
    end
  end

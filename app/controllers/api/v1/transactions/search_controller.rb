class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find_by(search_params.to_h))
  end

  def index
    render json: TransactionSerializer.new(Transaction.where(search_params.to_h))
  end

  private
    def search_params
      params.permit(:id, :invoice_id, :credit_card_number, :creadit_card_expiration_date, :result, :created_at, :updated_at)
    end
end

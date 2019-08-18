class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :items, dependent: :destroy

  def self.total_revenue(quantity)
    joins(items: [invoice_items: [:invoice]])
      .select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
      .group("merchants.id")
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.total_items_sold(quantity)
   joins(invoices: [:transactions, :invoice_items])
     .where("transactions.result = ?", "success")
     .select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
     .group("merchants.id")
     .order("items_sold DESC")
     .limit(quantity)
  end
end

class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :items, dependent: :destroy

  def self.most_revenue(quantity)
    joins(items: [invoice_items: [:invoice]])
      .select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
      .group("merchants.id")
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .select("merchants.*, SUM(invoice_items.quantity) AS total")
      .where("transactions.result = ?", "success")
      .group(:id).order("total DESC")
      .limit(quantity)
  end

  def favorite_customer
    cust = Customer.joins(invoices: [:transactions])
      .where("transactions.result = ?", "success")
      .select("customers.*, count(transactions.id) as sales")
      .group(:id)
      .order("sales desc")
      .limit(1)

      cust.to_a.shift
  end
end

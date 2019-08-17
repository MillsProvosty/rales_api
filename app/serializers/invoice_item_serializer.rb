class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :quantity, :unit_price
end

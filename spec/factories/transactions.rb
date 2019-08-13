FactoryBot.define do
  factory :transaction do
    invoice { "" }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2019-08-13" }
    result { "MyString" }
  end
end

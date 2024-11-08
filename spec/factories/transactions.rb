FactoryBot.define do
  factory :transaction do
    association :user
    currency_sent { 'USD' }
    currency_received { 'BTC' }
    amount_sent { 100.0 }
    amount_received { 0.001 }
  end
end
FactoryBot.define do
  factory :invoice do
    association :customer
    association :merchant
    status { ["shipped", "pending", "returned"].sample }
  end
end
# frozen_string_literal: true

# Discount Rates
module DiscountRates
  RATES = {
    0..20 => 0,
    21..50 => 0.1,
    51..100 => 0.15,
    101..Float::INFINITY => 0.2
  }.freeze
end

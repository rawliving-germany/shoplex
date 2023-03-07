# frozen_string_literal: true

require "test_helper"

class TestShoplexInvoice < Minitest::Test
  def test_that_it_computes_tax_gross_amounts
    invoice = Shoplex::ShopwareInvoice.new(
      tax07_amount:  7.0,
      tax19_amount: 19.0
    )
    assert_in_delta 107.0, invoice.tax07_gross_computed
    assert_in_delta 119.0, invoice.tax19_gross_computed
  end
end

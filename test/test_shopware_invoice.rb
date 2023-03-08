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

  def test_tax_includes_shipping
    invoice = Shoplex::ShopwareInvoice.new(
      shipping_gross: 100,
      tax07_amount:  7.54, # 100 / 1.07
      tax19_amount: 15.97 # gross: 100
    )
    assert_in_delta 50.0, invoice.shipping_tax07_computed
    assert_in_delta 50.0, invoice.shipping_tax19_computed
  end
end

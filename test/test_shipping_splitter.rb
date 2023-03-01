# frozen_string_literal: true

require "test_helper"

class TestShippingSlitter < Minitest::Test
  def test_easy_19_case
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 20,
                                           shipping_gross: 10,
                                           tax19_amount: 1.9)

    Shoplex::ShippingSplitter.apply!(invoice:)

    assert_equal 1.9 + 1.9, invoice.tax19_amount
  end
  def test_easy_07_case
    # if all os taxed 7%, shipping costs are too
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 20,
                                           shipping_gross: 10,
                                           tax07_amount: 0.7)

    Shoplex::ShippingSplitter.apply!(invoice:)

    assert_equal 0.7 + 0.7, invoice.tax07_amount
  end
end


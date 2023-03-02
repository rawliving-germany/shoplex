# frozen_string_literal: true

require "test_helper"

class TestShippingSlitter < Minitest::Test
  def test_it_adds_19_percent_of_shipping_if_all_articles_are_19_percent
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount:   20,
                                           shipping_gross: 4.95,
                                           shipping_net:   4.16,
                                           tax19_amount:      0)

    Shoplex::ShippingSplitter.apply!(invoice:)

    assert_equal 0.0      , invoice.tax07_amount.to_f
    assert_equal 0.0 + 4.95 - 4.16, invoice.tax19_amount
  end

  def test_it_adds_07_percent_of_shipping_if_all_articles_are_07_percent
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 20,
                                           shipping_gross: 10.7,
                                           shipping_net:   10,
                                           tax07_amount:  0.7)

    Shoplex::ShippingSplitter.apply!(invoice:)

    assert_equal 0.7 + 0.7, invoice.tax07_amount
    assert_equal 0.0      , invoice.tax19_amount
  end

  def test_5050_case
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 40,
                                           shipping_gross: 20 + 10 * 0.07 + 10 * 0.19,
                                           shipping_net:   20,
                                           tax07_amount:  0.7,
                                           tax19_amount:  1.9)

    Shoplex::ShippingSplitter.apply!(invoice:)

    assert_equal 0.7 + 0.7, invoice.tax07_amount
    assert_equal 1.9 + 1.9, invoice.tax19_amount
  end
end


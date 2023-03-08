# frozen_string_literal: true

require "test_helper"

class TestShippingSlitter < Minitest::Test
  def test_it_assigns_shuppung_to_19_if_all_articles_are_19_percent
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount:   20,
                                           shipping_gross: 4.95,
                                           shipping_net:   4.16,
                                           tax19_amount:      0)

    shipping07, shipping19 = Shoplex::ShippingSplitter.split(
      shipping_net:   invoice.shipping_net,
      shipping_gross: invoice.shipping_gross).values

    assert_in_delta  0.0, shipping07, 0.04
    assert_in_delta 4.95, shipping19, 0.04
  end

  def test_it_assigns_to_07_percent_if_all_articles_are_07_percent
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 20,
                                           shipping_gross: 10.7,
                                           shipping_net:   10,
                                           tax07_amount:  0.7)

    shipping07, shipping19 = Shoplex::ShippingSplitter.split(
      shipping_net:   invoice.shipping_net,
      shipping_gross: invoice.shipping_gross).values

    assert_in_delta 10.7, shipping07, 0.04
    assert_in_delta 0.00, shipping19, 0.04
  end

  def test_it_makes_halfhalf_if_5050
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 40,
                                           shipping_gross: 20 + 10 * 0.07 + 10 * 0.19,
                                           shipping_net:   20,
                                           tax07_amount:  0.7,
                                           tax19_amount:  1.9)

    shipping07, shipping19 = Shoplex::ShippingSplitter.split(
      shipping_net:   invoice.shipping_net,
      shipping_gross: invoice.shipping_gross).values

    assert_in_delta shipping07, shipping19, 0.04

    assert_in_delta 11.3, shipping07, 0.04
    assert_in_delta 11.3, shipping19, 0.04
  end
end


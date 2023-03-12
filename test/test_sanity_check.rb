# frozen_string_literal: true

require "test_helper"

class TestSanityCheck < Minitest::Test
  def test_that_it_raises_on_nomatch
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 100,
                                           invoice_amount_net: 80,
                                           tax07_amount: 5)
    assert_raises(Shoplex::SanityCheck::GrossDoesNotMatchNet) do
      Shoplex::SanityCheck.check!(invoice:)
    end
  end

  def test_that_it_does_not_raises_on_match
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 107,
                                           invoice_amount_net: 100,
                                           tax07_amount: 107)
    Shoplex::SanityCheck.check!(invoice:)

    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 107,
                                           invoice_amount_net: 100,
                                           shipping_net: 7,
                                           tax19_amount: 50,
                                           tax07_amount: 50)
    Shoplex::SanityCheck.check!(invoice:)
  end
end

# frozen_string_literal: true

require "test_helper"

class TestSanityCheck < Minitest::Test
  def test_that_it_raises_on_nomatch
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: 100, invoice_amount_net: 80,
                                  tax07_amount: 5)
    assert_raises(Shoplex::SanityCheck::GrossDoesNotMatchNet) do
      Shoplex::SanityCheck.check!(invoice:)
    end
  end
end

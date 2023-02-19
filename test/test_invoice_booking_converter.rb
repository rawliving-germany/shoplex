# frozen_string_literal: true

require "test_helper"

class TestInvoiceBookingConverter < Minitest::Test
  def test_it_converts_invoices_to_bookings
    invoice = Shoplex::ShopwareInvoice.new
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal Shoplex::Booking, result.first.class
  end
end


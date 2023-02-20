# frozen_string_literal: true

require "test_helper"

class TestInvoiceBookingConverter < Minitest::Test
  def test_it_converts_invoices_to_bookings
    invoice = Shoplex::ShopwareInvoice.new
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal Shoplex::Booking, result.first.class
  end

  def test_it_creates_3_lines_from_double_taxed_invoice
    assert false
  end
end


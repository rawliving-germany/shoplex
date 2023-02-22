# frozen_string_literal: true

require "test_helper"

class TestInvoiceBookingConverter < Minitest::Test
  def test_it_converts_invoices_to_bookings
    invoice = Shoplex::ShopwareInvoice.new(lastname: 'Arndt')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal Shoplex::Booking, result.first.class
  end

  def test_it_creates_3_lines_from_double_taxed_invoice
    invoice = Shoplex::ShopwareInvoice.new(lastname: 'Bok')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal 3, result.first.booking_lines.count
  end

  def test_it_sets_date_of_booking
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '12', order_time: DateTime.new(2011,1,1,11,11,11), lastname: 'Chan')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal DateTime.new(2011,1,1,11,11,11), result.first.date
  end

  def test_it_gets_the_gross_amount_right
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '12', lastname: 'Dion')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    assert_equal "12", result.first.booking_lines.first.gross_amount
  end

  def test_it_gets_booking_line_types_right
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '12', order_time: DateTime.new(2022,2,2,22,22,22), lastname: 'E.')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])

    booking = result.first
    line = booking.line(type: Shoplex::BookingLine::Types::GROSS)
    assert_equal '12', line.gross_amount
  end

  def test_it_gets_the_gross_accounts_right
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '12', lastname: 'Gerdz')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    booking = result.first
    line = booking.line(type: :gross)

    # TODO invert!
    assert_equal 10600, line.sending_account
    assert_equal     0, line.receiving_account
    assert_equal  "12", result.first.booking_lines.first.gross_amount
  end

  def test_it_gets_the_tax_accounts_right_eu_case
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '12', tax07_amount: '7.77', tax19_amount: '19.19', lastname: 'Gerdz')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    booking = result.first
    line = booking.line(type: :tax07)

    assert_equal      0, line.sending_account
    assert_equal   8300, line.receiving_account
    assert_equal "7.77", line.gross_amount
  end

  def test_it_gets_the_tax_accounts_right_non_eu_case
    invoice = Shoplex::ShopwareInvoice.new(invoice_amount: '1',
                                           tax07_amount: '7.77', tax19_amount: '19.19', lastname: 'Gerdz')
    result = Shoplex::InvoiceBookingConverter.convert(invoices: [invoice])
    booking = result.first
    line = booking.line(type: :tax07)

    assert_equal      0, line.sending_account
    assert_equal   8310, line.receiving_account
    assert_equal "7.77", line.gross_amount
  end
end


# frozen_string_literal: true

require_relative "shoplex/version"
require_relative "shoplex/invoice_booking_converter"
require_relative "shoplex/shopware_csv_parser"
require_relative "shoplex/shopware_invoice"

module Shoplex
  class Error < StandardError; end

  def self.process file_content
    shopware_invoices = Shoplex::ShopwareCSVParser.parse(file_content)
    bookings = Shoplex::InvoiceBookingConverter.convert(invoices: shopware_invoices)
    return "\n"
  end
end

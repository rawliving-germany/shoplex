# frozen_string_literal: true

require_relative "shoplex/version"
require_relative "shoplex/account_number"
require_relative "shoplex/booking"
require_relative "shoplex/booking_line"
require_relative "shoplex/invoice_booking_converter"
require_relative "shoplex/shopware_csv_parser"
require_relative "shoplex/shopware_invoice"

module Shoplex
  class Error < StandardError; end

  def self.process file_content
    shopware_invoices = Shoplex::ShopwareCSVParser.parse(file_content).invoices
    shopware_invoices.each do |invoice|
      bookings = Shoplex::InvoiceBookingConverter.convert(invoice:)
    end
    return "\n"
  end
end

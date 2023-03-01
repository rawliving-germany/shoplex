# frozen_string_literal: true

require_relative "shoplex/version"
require_relative "shoplex/account_number"
require_relative "shoplex/booking"
require_relative "shoplex/booking_line"
require_relative "shoplex/invoice_booking_converter"
require_relative "shoplex/lexware_csv"
require_relative "shoplex/shipping_splitter"
require_relative "shoplex/shopware_csv_parser"
require_relative "shoplex/shopware_invoice"

module Shoplex
  class Error < StandardError; end

  def self.process file_content
    shopware_invoices = Shoplex::ShopwareCSVParser.parse(file_content).invoices
    bookings = shopware_invoices.map do |invoice|
      begin
        Shoplex::InvoiceBookingConverter.convert(invoice:)
      rescue => e
        STDERR.puts e
      end
    end.compact

    return Shoplex::LexwareCSV.create_from(bookings:)
  end
end

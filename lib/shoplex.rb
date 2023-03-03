# frozen_string_literal: true

require_relative "shoplex/version"
require_relative "shoplex/account_number"
require_relative "shoplex/booking"
require_relative "shoplex/booking_line"
require_relative "shoplex/invoice_booking_converter"
require_relative "shoplex/lexware_csv"
require_relative "shoplex/result"
require_relative "shoplex/sanity_check"
require_relative "shoplex/shipping_splitter"
require_relative "shoplex/shopware_csv_parser"
require_relative "shoplex/shopware_invoice"

module Shoplex
  class Error < StandardError; end

  def self.process file_content
    result = Shoplex::ShopwareCSVParser.parse(file_content)
    bookings = result.invoices.map do |invoice|
      begin
        Shoplex::ShippingSplitter::apply!(invoice:)
        #Shoplex::SanityCheck::check!(invoice:)
        Shoplex::InvoiceBookingConverter.convert(invoice:)
      rescue => e
        result.mark_error(maker: self, error: :unknown, obj: [e, invoice])
        STDERR.puts e
        STDERR.puts e.backtrace
      end
    end.compact

    result.csv_out = Shoplex::LexwareCSV.create_from(bookings:)
    return result
  end
end

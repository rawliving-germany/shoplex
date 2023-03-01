require 'csv'

module Shoplex
  class ShopwareCSVParser
    class Result
      attr_accessor :valid_invoices, :invalid_invoices
      attr_accessor :invoices

      def initialize
        @valid_invoices, @invalid_invoices = 0 ,0
        @invoices = []
      end
    end

    def self.parse csv_file_content
      result = Result.new

      CSV.parse(csv_file_content, headers: true, col_sep: ';', converters:
                :date_time, encoding: Encoding::ISO_8859_1) do |row|
        if row['invoiceNumber']
          begin
            result.invoices << create_invoice_from(row: row)
            result.valid_invoices += 1
          rescue => e
            STDERR.puts e
          end
        else
          result.invalid_invoices += 1
        end
      end

      return result
    end

    def self.create_invoice_from(row:)
      ShopwareInvoice.new(invoice_number: row["invoiceNumber"],
                          order_number:   row['orderNumber'],
                          order_time:     row['orderTime'],
                          tax00_amount:   row['taxRateSums_0'],
                          tax07_amount:   row['taxRateSums_7'],
                          tax19_amount:   row['taxRateSums_19'],
                          invoice_amount: row['invoiceAmount'],
                          shipping_gross: row['invoiceShipping'],
                          lastname:       row['billingLastName'],)
    end
  end
end

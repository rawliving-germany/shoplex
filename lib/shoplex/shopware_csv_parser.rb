require 'csv'

module Shoplex
  class ShopwareCSVParser
    def self.parse csv_file_content
      result = Shoplex::Result.new

      CSV.parse(csv_file_content, headers: true, col_sep: ';', converters:
                :date_time, encoding: Encoding::ISO_8859_1) do |row|
        if row['invoiceNumber']
          begin
            convert_tax_numbers!(row:)
            convert_shipping_and_amount__numbers!(row:)
            result.invoices << create_invoice_from(row:)
          rescue => e
            result.mark_error(maker: self, error: :creation_failed, obj: [e, row])
            STDERR.puts e
            STDERR.puts e.backtrace
          end
        else
          result.mark_error(maker: self, error: :no_invoice_number, obj: row)
        end
      end

      return result
    end

    def self.convert_tax_numbers!(row:)
      row["taxRateSums_7"]  = row["taxRateSums_7"].to_f
      row["taxRateSums_19"] = row["taxRateSums_19"].to_f
    end

    def self.convert_shipping_and_amount__numbers!(row:)
      row["invoiceShipping"]    = row["invoiceShipping"].to_s.gsub(",",".").to_f
      row["invoiceShippingNet"] = row["invoiceShippingNet"].to_s.gsub(",",".").to_f
      row["invoiceAmount"]      = row["invoiceAmount"].to_s.gsub(",",".").to_f
      row["invoiceAmountNet"]   = row["invoiceAmountNet"].to_s.gsub(",",".").to_f
    end

    def self.create_invoice_from(row:)
      ShopwareInvoice.new(invoice_number: row["invoiceNumber"],
                          order_number:   row['orderNumber'],
                          order_time:     row['orderTime'],
                          tax00_amount:   row['taxRateSums_0'],
                          tax07_amount:   row['taxRateSums_7'],
                          tax19_amount:   row['taxRateSums_19'],
                          invoice_amount: row['invoiceAmount'],
                          invoice_amount_net: row['invoiceAmountNet'],
                          shipping_gross: row['invoiceShipping'],
                          shipping_net:   row['invoiceShippingNet'],
                          country:        row['billingCountry'],
                          lastname:       row['billingLastName'],)
    end
  end
end

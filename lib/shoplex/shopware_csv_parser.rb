require 'csv'

module Shoplex
  class ShopwareCSVParser
    def self.parse csv_file_content
      result = Shoplex::Result.new

      CSV.parse(csv_file_content, headers: true, col_sep: ';',
                liberal_parsing: true,
                converters: :date_time, encoding: Encoding::UTF_8) do |row|
        if row['Dokument ID']
          begin
            convert_tax_numbers!(row:)
            convert_shipping_and_amount_numbers!(row:)
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
      row["Bruttobetrag 7%"]  = row["Bruttobetrag 7%"].to_s.gsub(',','.').to_f
      row["Bruttobetrag 19%"] = row["Bruttobetrag 19%"].to_s.gsub(',','.').to_f
    end

    def self.convert_shipping_and_amount_numbers!(row:)
      row["Brutto Versandkosten"] = row["Brutto Versandkosten"].to_s.gsub(",",".").to_f
      row["Netto Versandkosten"]  = row["Netto Versandkosten"].to_s.gsub(",",".").to_f
      row["Bruttobetrag"]         = row["Bruttobetrag"].to_s.gsub(",",".").to_f
      row["Nettobetrag"]          = row["Nettobetrag"].to_s.gsub(",",".").to_f
    end

    def self.create_invoice_from(row:)
      ShopwareInvoice.new(invoice_number: row["Dokument ID"],
                          order_number:   row['Bestellnummer'],
                          order_time:     row['Datum der Bestellung'],
                          tax00_amount:   row['Bruttobetrag 0%'],
                          tax07_amount:   row['Bruttobetrag 7%'],
                          tax19_amount:   row['Bruttobetrag 19%'],
                          invoice_amount: row['Bruttobetrag'],
                          invoice_amount_net: row['Nettobetrag'],
                          shipping_gross: row['Brutto Versandkosten'],
                          shipping_net:   row['Netto Versandkosten'],
                          country:        row['Land'],
                          lastname:       row['Nachname'],)
    end
  end
end

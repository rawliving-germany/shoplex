require 'csv'

module Shoplex
  class ShopwareCSVParser
    class InvoiceNumberMissing < StandardError ; end
    class DisallowedValues < StandardError ; end

    def self.parse csv_file_content
      result = Shoplex::Result.new

      CSV.parse(csv_file_content, headers: true, col_sep: ';',
                liberal_parsing: true,
                converters: :date_time, encoding: Encoding::UTF_8) do |row|
        if row['Dokument ID']
          begin
            sanity_check!(row:)
            convert_tax_numbers!(row:)
            convert_shipping_and_amount_numbers!(row:)
            result.invoices << create_invoice_from(row:)
          rescue => e
            result.mark_error(maker: self, error: :creation_failed, obj: [e, row])
            STDERR.puts e
            STDERR.puts e.backtrace
          end
        else
          result.mark_error(maker: self, error: :no_invoice_number, obj: [InvoiceNumberMissing.new('invoice number missing'), row])
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
                          order_time:     row['Datum des Beleges'],
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

    def self.sanity_check!(row:)
      disallowed_fields =[
        "Bruttobetrag 0%","Bruttobetrag 9%","Bruttobetrag 10%","Bruttobetrag 13%","Bruttobetrag 14%","Bruttobetrag 17%","Bruttobetrag 20%","Bruttobetrag 21%","Bruttobetrag 23%","Bruttobetrag 25%","UST ID"
      ]
      disallowed_fields.each do |f|
        if row[f].to_s != ""
          raise DisallowedValues.new("Value in '#{f}' not allowed")
        end
      end
    end
  end
end

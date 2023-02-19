require 'csv'

module Shoplex
  class ShopwareCSVParser
    class Result
      attr_accessor :valid_invoices, :invalid_invoices

      def initialize
        @valid_invoices, @invalid_invoices = 0 ,0
      end
    end

    def self.parse csv_file_content
      result = Result.new

      CSV.parse(csv_file_content, headers: true, col_sep: ';') do |row|
        if row['invoiceNumber']
          result.valid_invoices += 1
        else
          result.invalid_invoices += 1
        end
      end

      return result
    end
  end
end

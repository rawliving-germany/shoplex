module Shoplex
  class SanityCheck
    class GrossDoesNotMatchNet < StandardError ; end
    TOLERANCE = 0.01
    def self.check!(invoice:)
      gross_tax_sum = (invoice.tax07_amount + invoice.tax19_amount)
      if absdiff(invoice.invoice_amount, gross_tax_sum) >= TOLERANCE
        raise GrossDoesNotMatchNet.new(
          "Gross amount #{invoice.invoice_amount} does not equal tax sums "\
          "(#{invoice.tax07_amount} "\
          "+ #{invoice.tax19_amount} == #{gross_tax_sum})")
      end
    end

    def self.absdiff a, b
      (a-b).abs
    end
  end
end

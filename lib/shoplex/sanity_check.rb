module Shoplex
  class SanityCheck
    class GrossDoesNotMatchNet < StandardError ; end
    def self.check!(invoice:)
      gross_tax_sum = (invoice.tax07_amount + invoice.tax19_amount).round(2) + invoice.shipping_net
      if invoice.invoice_amount != gross_tax_sum
        raise GrossDoesNotMatchNet.new(
          "Gross amount #{invoice.invoice_amount} does not equal tax sums "\
          "(#{invoice.tax07_amount} "\
          "+ #{invoice.tax19_amount} == #{gross_tax_sum})")
      end
    end
  end
end

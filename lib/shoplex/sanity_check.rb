module Shoplex
  class SanityCheck
    class GrossDoesNotMatchNet < StandardError ; end
    def self.check!(invoice:)
      net_tax_sum = (invoice.invoice_amount_net + invoice.tax07_amount + invoice.tax19_amount).round(2)
      if invoice.invoice_amount != net_tax_sum
        raise GrossDoesNotMatchNet.new(
          "Gross amount #{invoice.invoice_amount} does not equal net + tax sums "\
          "(#{invoice.invoice_amount_net} "\
          "+ #{invoice.tax07_amount} "\
          "+ #{invoice.tax19_amount} == #{net_tax_sum})")
      end
    end
  end
end

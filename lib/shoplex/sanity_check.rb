module Shoplex
  class SanityCheck
    class GrossDoesNotMatchNet < StandardError ; end
    def self.check!(invoice:)
      if invoice.invoice_amount != invoice.invoice_amount_net + invoice.tax07_amount + invoice.tax19_amount
        raise GrossDoesNotMatchNet
      end
    end
  end
end

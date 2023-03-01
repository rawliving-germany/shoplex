module Shoplex
  class ShippingSplitter
    def self.apply!(invoice:)
      cost_without_shipping = invoice.invoice_amount - invoice.shipping_gross.to_f

      gross19 = invoice.tax19_amount.to_f / 0.19
      gross07 = invoice.tax07_amount.to_f / 0.07
      # div/0
      ratio19 = case
                when gross07 == 0
                  1
                when gross19 == 0
                  0
                else
                  (gross19 / gross07 ) / (gross19 + gross07)
                end

      shipping_cost_19part = invoice.shipping_gross * ratio19
      shipping_cost_07part = invoice.shipping_gross - shipping_cost_19part
      
      invoice.tax19_amount += shipping_cost_19part * 0.19
    end
  end
end

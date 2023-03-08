module Shoplex
  class ShippingSplitter
    def self.apply!(invoice:)
      return if invoice.shipping_net.to_i == 0 || invoice.shipping_gross.to_i == 0

      #https://www.wolframalpha.com/input?i=solve+a+%2B+b+%3D+1+AND+g+-+n+%3D+0.07+*+a+*+n+%2B+0.19+*+b+*+n+for+a


      ratio_07 = (119 / 12.0) - (25 * invoice.shipping_gross) / (3 * invoice.shipping_net)
      ratio_19 = 1.0 - ratio_07

      shipping_cost_19part = invoice.shipping_net * ratio_19
      shipping_cost_07part = invoice.shipping_net * ratio_07

      invoice.tax19_amount = invoice.tax19_amount.to_f + shipping_cost_19part * 0.19
      invoice.tax07_amount = invoice.tax07_amount.to_f + shipping_cost_07part * 0.07

      invoice.tax19_amount = invoice.tax19_amount.round(2)
      invoice.tax07_amount = invoice.tax07_amount.round(2)
    end

    def self.split(shipping_net:, shipping_gross:)
      return Hash.new(0) if shipping_gross.to_i == 0

      ratio_07 = (119 / 12.0) - (25 * shipping_gross) / (3 * shipping_net)
      ratio_19 = 1.0 - ratio_07

      shipping_cost_07part = shipping_gross * ratio_07
      shipping_cost_19part = shipping_gross * ratio_19

      {
        shipping_cost_07part:,
        shipping_cost_19part:
      }
    end
  end
end

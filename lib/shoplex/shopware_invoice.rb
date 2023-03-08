module Shoplex
  ShopwareInvoice = Struct.new(:invoice_number,
                               :order_number,
                               :firstname, :lastname,
                               :country,
                               :order_time,
                               :invoice_amount, :invoice_amount_net,
                               :tax00_amount,
                               :tax07_amount,
                               :tax19_amount,
                               :shipping_gross, :shipping_net,
                               keyword_init: true) do

    # provide defaults (floats for the numbers)
    def initialize(invoice_number: nil,
                   order_number:   nil,
                   firstname: nil, lastname: nil,
                   country: nil,
                   order_time: nil,
                   invoice_amount: 0.0, invoice_amount_net: 0.0,
                   tax00_amount: 0.0,
                   tax07_amount: 0.0,
                   tax19_amount: 0.0,
                   shipping_gross: 0.0, shipping_net: 0.0
                   )
      super
    end

    def german?
      country == "Deutschland"
    end

    def tax07_gross_computed
      tax07_amount / 0.07 * 1.07 + shipping_tax07_computed
    end

    def tax19_gross_computed
      tax19_amount / 0.19 * 1.19 + shipping_tax19_computed
    end

    def shipping_tax07_computed
      ShippingSplitter.split(shipping_net:,
                             shipping_gross:)[:shipping_cost_07part]
    end

    def shipping_tax19_computed
      ShippingSplitter.split(shipping_net:,
                             shipping_gross:)[:shipping_cost_19part]
    end
  end
end

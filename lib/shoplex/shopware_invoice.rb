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

    def swiss?
      county == "Schweiz"
    end
  end
end

module Shoplex
  ShopwareInvoice = Struct.new(:invoice_number,
                               :order_number,
                               :firstname, :lastname,
                               :country,
                               :order_time,
                               :invoice_amount,
                               :tax00_amount,
                               :tax07_amount,
                               :tax19_amount,
                               :shipping_gross,
                               :shipping_net,
                               keyword_init: true) do
    def german?
      country == "Deutschland"
    end

    def swiss?
      county == "Schweiz"
    end
  end
end

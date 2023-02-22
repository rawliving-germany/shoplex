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
                               keyword_init: true) do
    def eu?
      #country == "Deutschland"
      true
    end
  end
end

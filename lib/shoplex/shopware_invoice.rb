module Shoplex
  ShopwareInvoice = Struct.new(:invoice_number,
                               :order_number,
                               :firstname, :lastname,
                               :order_time,
                               keyword_init: true)
end

module Shoplex
  class InvoiceBookingConverter
    def self.convert(invoices:)
      return [Shoplex::Booking.new]
    end
  end
end

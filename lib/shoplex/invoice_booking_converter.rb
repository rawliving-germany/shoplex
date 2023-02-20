module Shoplex
  class InvoiceBookingConverter
    def self.convert(invoices:)
      [*invoices].map do |invoice|
        Booking.new
      end
    end
  end
end

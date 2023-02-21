module Shoplex
  class InvoiceBookingConverter
    def self.convert(invoices:)
      [*invoices].map do |invoice|
        booking = Booking.new

        add_gross_booking_line(invoice:, booking:)
        add_tax07_booking_line(invoice:, booking:)
        add_tax19_booking_line(invoice:, booking:)

        booking
      end
    end

    def self.add_gross_booking_line(invoice:, booking:)
      booking.booking_lines << Shoplex::BookingLine.new(date: Time.now,
                                                        sending_account: 0,
                                                        receiving_account: 0,
                                                        gross_amount: invoice.invoice_amount,
                                                        reference: '')
    end

    def self.add_tax07_booking_line(...)
      self.add_gross_booking_line(...)
    end

    def self.add_tax19_booking_line(...)
      self.add_gross_booking_line(...)
    end
  end
end

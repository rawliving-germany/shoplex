module Shoplex
  class InvoiceBookingConverter
    def self.convert(invoices:)
      [*invoices].map do |invoice|
        booking = Booking.new(date: invoice.order_time)

        add_gross_booking_line(invoice:, booking:)
        add_tax07_booking_line(invoice:, booking:)
        add_tax19_booking_line(invoice:, booking:)

        booking
      end
    end

    def self.add_gross_booking_line(invoice:, booking:)
      booking.add_line Shoplex::BookingLine.new(sending_account: 0,
                                                receiving_account: Shoplex::AccountNumber::sending_gross(lastname: invoice.lastname),
                                                gross_amount: invoice.invoice_amount,
                                                reference: '',
                                                type: BookingLine::Types::GROSS)
    end

    def self.add_tax00_booking_line(invoice:, booking:)
      booking.add_line Shoplex::BookingLine.new(sending_account: 0,
                                                receiving_account: Shoplex::AccountNumber::sending_gross(lastname: invoice.lastname),
                                                gross_amount: invoice.invoice_amount,
                                                reference: '',
                                                type: BookingLine::Types::TAX00)
    end

    def self.add_tax07_booking_line(invoice:, booking:)
      booking.add_line Shoplex::BookingLine.new(sending_account: 0,
                                                receiving_account: Shoplex::AccountNumber::sending_gross(lastname: invoice.lastname),
                                                gross_amount: invoice.invoice_amount,
                                                reference: '',
                                                type: BookingLine::Types::TAX07)
    end

    def self.add_tax19_booking_line(invoice:, booking:)
      booking.add_line Shoplex::BookingLine.new(sending_account: 0,
                                                receiving_account: Shoplex::AccountNumber::sending_gross(lastname: invoice.lastname),
                                                gross_amount: invoice.invoice_amount,
                                                reference: '',
                                                type: BookingLine::Types::TAX19)
    end
  end
end

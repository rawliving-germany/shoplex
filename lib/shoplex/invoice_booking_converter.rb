module Shoplex
  class InvoiceBookingConverter
    def self.convert(invoice:)
      booking = Booking.new(date: invoice.order_time, reference: invoice.invoice_number)

      add_gross_booking_line(invoice:, booking:)
      [
        [:tax00, AccountNumber::method(:receiving_tax00), :tax00_amount],
        [:tax07, AccountNumber::method(:receiving_tax07), :tax07_amount],
        [:tax19, AccountNumber::method(:receiving_tax19), :tax19_amount],
      ].each do |type, account_number_method, invoice_amount_accessor|
        add_tax_booking_line(invoice:, booking:, type:, account_number_method:, invoice_amount_accessor:)
      end

      booking
    end

    def self.create_reference invoice:
      "#{invoice.invoice_number} #{invoice.order_number} #{invoice.firstname} #{invoice.lastname}"
    end

    def self.add_gross_booking_line(invoice:, booking:)
      booking.add_line Shoplex::BookingLine.new(sending_account: Shoplex::AccountNumber::sending_gross(lastname: invoice.lastname),
                                                receiving_account: 0,
                                                gross_amount: invoice.invoice_amount,
                                                reference: create_reference(invoice:),
                                                type: BookingLine::Types::GROSS)
    end

    def self.add_tax_booking_line(invoice:, booking:, type:, account_number_method:, invoice_amount_accessor:)
      return if invoice.send(invoice_amount_accessor).to_f == 0.0

      line = Shoplex::BookingLine.new(
        sending_account: 0,
        receiving_account: account_number_method.(german: invoice.german?),
        gross_amount: invoice.send(invoice_amount_accessor),
        reference: create_reference(invoice:),
        type:)
      booking.add_line line
    end
  end
end

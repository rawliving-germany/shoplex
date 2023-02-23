module Shoplex
  class LexwareCSV
    def self.create_from(bookings:)
      CSV.generate do |csv|
        bookings.each do |booking|
          booking.booking_lines.each do |line|
            csv << [
              booking.date,
              #line.invoice_number,
              line.reference,
              line.gross_amount,
              line.sending_account,
              line.receiving_account,
              'EUR'
            ]
          end
        end
      end
    end
  end
end

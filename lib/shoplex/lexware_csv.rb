module Shoplex
  class LexwareCSV
    def self.create_from(bookings:)
      CSV.generate(encoding: Encoding::ISO_8859_1) do |csv|
        bookings.each do |booking|
          booking.booking_lines.each do |line|
            csv << [
              booking.date.strftime("%d.%m.%Y"),
              booking.reference,
              line.reference,
              "%.2f" % line.gross_amount.to_f,
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

class Shoplex::BookingJoiner
  def self.merge! booking:
    return if booking.lines.count != 2

    raise if Shoplex::SanityCheck::absdiff(*booking.lines.map(&:gross_amount)) > 0.1

    gross_line = booking.line(type: Shoplex::BookingLine::Types::GROSS)
    other_line = (booking.booking_lines - [gross_line]).first

    gross_line.receiving_account = other_line.receiving_account
    booking.booking_lines.delete other_line
  end

  def self.tax07_line_only? booking:
    raise if Shoplex::SanityCheck::absdiff(*booking.lines.map(&:gross_amount)) > 0.1

    booking.lines.map(&:type) == [Shoplex::BookingLine::Types::GROSS, Shoplex::BookingLine::Types::TAX07]
  end

  def self.tax19_line_only? booking:
    raise if Shoplex::SanityCheck::absdiff(*booking.lines.map(&:gross_amount)) > 0.1

    booking.lines.map(&:type) == [Shoplex::BookingLine::Types::GROSS, Shoplex::BookingLine::Types::TAX19]
  end
end

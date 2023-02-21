class Shoplex::Booking
  attr_reader :booking_lines, :date

  def initialize(date:)
    @booking_lines = []
    @date = date
  end

  def line(type:)
    @booking_lines.select{_1.type == type}.first
  end

  def lines
    @booking_lines.dup.freeze
  end

  def add_line(booking_line)
    booking_line.booking = self
    @booking_lines << booking_line
  end
end

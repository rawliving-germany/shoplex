class Shoplex::Booking
  attr_reader :booking_lines, :date, :reference

  def initialize(date:, reference:)
    @booking_lines = []
    @date = date
    @reference = reference
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

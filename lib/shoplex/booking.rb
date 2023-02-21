class Shoplex::Booking
  attr_accessor :booking_lines

  def initialize
    @booking_lines = []
  end

  def line(type:)
    @booking_lines.select{_1.type == type}.first
  end
end

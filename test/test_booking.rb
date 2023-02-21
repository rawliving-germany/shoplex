# frozen_string_literal: true

require "test_helper"

class TestBooking < Minitest::Test
  def test_it_can_access_booking_lines_by_type
    booking = Shoplex::Booking.new
    booking.booking_lines << Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::GROSS)
    booking.booking_lines << Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::TAX00)
    booking.booking_lines << Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::TAX07)
    booking.booking_lines << Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::TAX19)

    gross_line = booking.line(type: Shoplex::BookingLine::Types::GROSS)
    assert gross_line

    tax00_line = booking.line(type: Shoplex::BookingLine::Types::TAX00)
    assert tax00_line

    tax07_line = booking.line(type: Shoplex::BookingLine::Types::TAX07)
    assert tax07_line

    tax19_line = booking.line(type: Shoplex::BookingLine::Types::TAX19)
    assert tax19_line
  end

  def test_it_raises_on_multiple_lines_of_type
    # assert false
  end

  def test_it_raises_on_multiple_lines_of_type
    booking = Shoplex::Booking.new
    booking.booking_lines << Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::GROSS)

    weird_line = booking.line(type: :unknown)

    refute weird_line
  end
end

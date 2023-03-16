# frozen_string_literal: true

require "test_helper"

class TestBookingJoiner < Minitest::Test
  def test_it_does_not_join_different_tax_lines
    booking = Shoplex::Booking.new(date: nil, reference: nil)
    booking.add_line Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::GROSS)
    booking.add_line Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::TAX07)
    booking.add_line Shoplex::BookingLine.new(
      type: Shoplex::BookingLine::Types::TAX19)

    Shoplex::BookingJoiner::merge!(booking:)
    assert_equal 3, booking.lines.count
  end

  def test_it_does_join_if_only_tax07
    booking = Shoplex::Booking.new(date: nil, reference: nil)
    booking.add_line Shoplex::BookingLine.new(
      gross_amount: 7,
      type: Shoplex::BookingLine::Types::GROSS)
    booking.add_line Shoplex::BookingLine.new(
      gross_amount: 7,
      type: Shoplex::BookingLine::Types::TAX07)

    Shoplex::BookingJoiner::merge!(booking:)
    assert_equal 1, booking.lines.count
  end

  def test_it_does_join_if_only_tax19
    booking = Shoplex::Booking.new(date: nil, reference: nil)
    booking.add_line Shoplex::BookingLine.new(
      gross_amount: 19,
      type: Shoplex::BookingLine::Types::GROSS)
    booking.add_line Shoplex::BookingLine.new(
      gross_amount: 19,
      type: Shoplex::BookingLine::Types::TAX19)

    Shoplex::BookingJoiner::merge!(booking:)
    assert_equal 1, booking.lines.count
  end
end

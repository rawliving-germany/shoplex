# frozen_string_literal: true

require "test_helper"

class TestLexwareCSV < Minitest::Test
  def test_it_includes_all_lines
    booking = Shoplex::Booking.new(date: Date.new(2022,2,22))
    booking.add_line Shoplex::BookingLine.new(sending_account: 1, receiving_account: 2, type: :gross)
    booking.add_line Shoplex::BookingLine.new(sending_account: 3, receiving_account: 4, type: :tax00)
    booking.add_line Shoplex::BookingLine.new(sending_account: 5, receiving_account: 6, type: :tax19)
    csv = Shoplex::LexwareCSV.create_from(bookings: [booking])
    assert_equal 3, csv.lines.count
  end

  def test_generates_right_output
    booking = Shoplex::Booking.new(date: Date.new(2022,2,22))
    booking.add_line Shoplex::BookingLine.new(sending_account: 1, receiving_account: 2, reference: 'r', type: :gross)
    csv = Shoplex::LexwareCSV.create_from(bookings: [booking])
    assert_equal '22.2.2022,', csv
  end
end

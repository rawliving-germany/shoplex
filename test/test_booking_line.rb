# frozen_string_literal: true

require "test_helper"

class TestBookingLine < Minitest::Test
  def test_it_validates_its_type
    assert_raises(Shoplex::BookingLine::Types::UnsupportedType) do
      Shoplex::BookingLine.new(type: :vanilla)
    end
    assert Shoplex::BookingLine.new(type: Shoplex::BookingLine::Types::GROSS)
  end
end
